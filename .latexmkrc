# put output files in _build/ folder
$out_dir = '_build';

# for mpost and feynmp to find the file in the output folder
add_cus_dep('mp', '1', 0, 'mpost');
sub mpost {
    my $file = $_[0];
    my ($name, $path) =  fileparse( $file );
    pushd( $path );
    my $return = system "mpost $name" ;
    popd();
    return $return;
}

# for clean
$clean_ext = "bbl out snm synctex.gz";
