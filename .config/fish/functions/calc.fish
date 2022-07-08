function calc
    set result (echo "scale=10;$argv" | bc -l)
    if  string match -q '*.*' $result then
       set result (echo $result | sed 's/^\./0./' | sed 's/^-\./-0./' | sed  's/0*$//;s/\.$//')
    end
    echo $result
end
