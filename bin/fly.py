from arrow import get as arrow_get
from re import match
import argparse
from lxml import html
from requests import get
from datetime import timezone, time

parser = argparse.ArgumentParser()
parser.add_argument("flight_number", type=str, help="Such as LX252")
parser.add_argument("date", type=str, help="(YY)YY-MM(-DD)")
parser.add_argument("--type", help="Output type. can be ical, khal", default="khal")

args = parser.parse_args()
args.type = args.type.lower()

if args.type not in ("khal", "ical"):
    raise ValueError(f"type must be either ical or khal")

try:
    arrow_get(args.date, ["YYYY-M-D", "YY-M-D", "YYYY-M", "YY-M"])
except:
    raise ValueError("The specified date is incorrect")

date_complete = len(args.date.split("-")) == 3

m = match(r"(\w\w)[\s-]?(\d{2,4})", args.flight_number)
if m:
    prefix, number = m.group(1), m.group(2)
else:
    raise ValueError(f"The flight code {args.flight_number} is incorrect")


r = get("https://swiss.flight-status.info/lx-252")
tree = html.fromstring(r.content)
departure_time, arrival_time = (
    s.strip() for s in tree.xpath("//div[contains(./text(), 'Scheduled')]/b/text()")
)
airport_from, city_from = (
    s.strip()
    for s in tree.xpath("//div[contains(./text(), 'Departure Airport')]/text()[2]")
    .pop()
    .split(",")[0:2]
)
airport_to, city_to = (
    s.strip()
    for s in tree.xpath("//div[contains(./text(), 'Arrival Airport')]/text()[2]")
    .pop()
    .split(",")[0:2]
)


def get_tzs():
    tzs = [
        s.split(": ")[1].strip()
        for s in tree.xpath("//div[contains(./text(), 'Time Zone')]/text()")
    ]
    if any("GMT" not in tz for tz in tzs):
        raise ValueError()

    def ensure_tz(s):
        m = match(r"GMT\s*([+-])(\d\d?)(:\d\d)?", s.strip())
        if not m:
            raise ValueError(
                "The timezone returned by the server are in an unexpected format"
            )
        hour = m.group(2)
        if len(hour) == 1:
            hour = "0" + hour
        return f"{m.group(1)}{hour}{m.group(3) or ':00'}"

    return tuple(ensure_tz(t) for t in tzs)


tz_from, tz_to = get_tzs()

days = {
    d.strip()
    for d in tree.xpath("//div[contains(./text(), 'Operating Days')]/text()")[0]
    .split(": ")[1]
    .split(",")
}


if not date_complete:
    departure = arrow_get(args.date + "-01" + "T" + departure_time + tz_from)
    arrival = arrow_get(args.date + "-01" + "T" + arrival_time + tz_to)
else:
    departure = arrow_get(args.date + "T" + departure_time + tz_from)
    arrival = arrow_get(args.date + "T" + arrival_time + tz_to)

if arrival < departure:
    arrival = departure.shift(days=1)

if args.type == "khal":
    from dateutil import tz

    departure = departure.to(tz.gettz("GMT"))
    arrival = arrival.to(tz.gettz("GMT"))
    print(
        f"khal new {departure.format('YYYY-MM-DD HH:mm')} "
        f"{arrival.format('HH:mm ZZZ')} "
        f"Flight {prefix.upper()}{number} to {city_to} "
        f"-l '{airport_from}, {city_from}'"
    )
