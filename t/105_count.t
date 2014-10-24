use strict;
use warnings;
use utf8;
use Test::Declare;
use YAML;

use lib './t';
use Mock::Basic;

plan tests => blocks;

describe 'count test' => run {
    init {
        Mock::Basic->setup_test_db;
    };

    test 'count' => run {
        Mock::Basic->insert('mock_basic',{
            id   => 1,
            name => 'perl',
        });

        is +Mock::Basic->count('mock_basic' => 'id'), 1;

        Mock::Basic->insert('mock_basic',{
            id   => 2,
            name => 'ruby',
        });

        is +Mock::Basic->count('mock_basic' => 'id'), 2;
        is +Mock::Basic->count('mock_basic' => 'id',{name => 'perl'}), 1;
    };

    test 'iterator count' => run {
        is +Mock::Basic->search('mock_basic',{  })->count, 2;
    };

    cleanup {
        if ( $ENV{SKINNY_PROFILE} ) {
            warn "query log";
            warn YAML::Dump(Mock::Basic->profiler->query_log);
        }
    };
};

