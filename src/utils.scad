module copy_mirror(v) {
    children();
    mirror(v) children();
}

module arrange(spacing=50, n=5) {
    nparts = $children;
    for(i=[0:1:n-1], j=[0:nparts/n])
        if (i+n*j < nparts)
            translate([(-spacing*(n/2)) + spacing*(i+1), spacing*j, 0]) 
                children(i+n*j);
 }
