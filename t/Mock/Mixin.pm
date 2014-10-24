package Mock::Mixin;
use DBIx::Skinny connect_info => +{
    dsn => 'dbi:SQLite:',
    username => '',
    password => '',
};
use DBIx::Skinny::Mixin modules => ['+Mixin::Foo'];

sub setup_test_db {
    shift->do(q{
        CREATE TABLE mock_mixin (
            id   INT,
            name TEXT
        )
    });
}

package Mock::Mixin::Schema;
use utf8;
use DBIx::Skinny::Schema;

install_table mock_mixin => schema {
    pk 'id';
    columns qw/
        id
        name
    /;
};

1;

