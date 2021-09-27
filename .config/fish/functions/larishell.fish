function larishell
    echo Connecting to $argv[1].lari.systems...
    ssh -t $argv[1].lari.systems 'sudo -i -u lari-backend bash -c "cd ~/../backend;. ./setup_venv.sh;./manage.py shell"'
end
