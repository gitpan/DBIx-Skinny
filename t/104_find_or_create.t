use strict;
use warnings;
use utf8;
use Test::Declare;
use YAML;

use lib './t';
use Mock::Basic;

plan tests => blocks;

describe 'find_or_create test' => run {
    init {
        Mock::Basic->setup_test_db;
    };

    test 'find_or_create' => run {
        my $mock_basic = Mock::Basic->find_or_create('mock_basic',{
            id   => 1,
            name => 'perl',
        });
        is $mock_basic->name, 'perl';

        $mock_basic = Mock::Basic->find_or_create('mock_basic',{
            id   => 1,
            name => 'perl',
        });
        is $mock_basic->name, 'perl';

        is +Mock::Basic->count('mock_basic', 'id',{name => 'perl'}), 1;
    };

    test 'find_or_insert' => run {
        my $mock_basic = Mock::Basic->find_or_insert('mock_basic',{
            id   => 2,
            name => 'ruby',
        });
        is $mock_basic->name, 'ruby';

        $mock_basic = Mock::Basic->find_or_insert('mock_basic',{
            id   => 2,
            name => 'ruby',
        });
        is $mock_basic->name, 'ruby';

        is +Mock::Basic->count('mock_basic', 'id',{name => 'ruby'}), 1;
    };

    cleanup {
        if ( $ENV{SKINNY_PROFILE} ) {
            warn "query log";
            warn YAML::Dump(Mock::Basic->profiler->query_log);
        }
    };
};

