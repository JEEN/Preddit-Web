{
    schema_class => "Preddit::Schema",
    connect_info => {
        dsn  => $ENV{DB_DSN}      || "dbi:mysql:preddit:127.0.0.1",
        user => $ENV{DB_USER}     || "preddit",
        pass => $ENV{DB_PASSWORD} || "preddit",
        mysql_enable_utf8  => 1,
    },
    loader_options => {
        dump_directory     => 'lib',
        naming             => { ALL => 'v8' },
        skip_load_external => 1,
        relationships      => 1,

        use_moose          => 1,
        only_autoclean     => 1,
        result_base_class  => 'Preddit::Schema::ResultBase',
        col_collision_map  => 'column_%s',
        datetime_undef_if_invalid => 1,
        overwrite_modifications   => 1,        
        custom_column_info => sub {
            my ($table, $col_name, $col_info) = @_;

            if ($col_name eq 'passwd') {
                return { %{ $col_info },
                    encode_column => 1,
                    encode_class  => 'Digest',
                    encode_args   => { algorithm => 'SHA-1', format => 'hex' },
                    encode_check_method => 'check_password' };
            }

            if ($col_name =~ /^(?:data|tags)$/) {
                return { %{ $col_info }, serializer_class => 'JSON' };
            }

            if ($col_name eq 'created_at') {
                return { %{ $col_info }, set_on_create => 1, inflate_datetime => 1 };
            }

            if ($col_name eq 'updated_at') {
                return { %{ $col_info }, set_on_create => 1, set_on_update => 1, inflate_datetime => 1 };
            }

            if ($col_info->{data_type} eq 'date') {
                return { %{ $col_info }, inflate_datetime => 1 };
            }
            
            return $col_info;
        },
    },
},
