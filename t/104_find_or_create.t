use t::Utils;
use Mock::Basic;
use Test::More;

Mock::Basic->setup_test_db;

subtest 'find_or_create' => sub {
    my $mock_basic = Mock::Basic->find_or_create('mock_basic',{
        id   => 1,
        name => 'perl',
    });
    is $mock_basic->name, 'perl';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    $mock_basic = Mock::Basic->find_or_create('mock_basic',{
        id   => 1,
        name => 'perl',
    });
    is $mock_basic->name, 'perl';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    is +Mock::Basic->count('mock_basic', 'id',{name => 'perl'}), 1;
    done_testing;
};

subtest 'find_or_insert' => sub {
    my $mock_basic = Mock::Basic->find_or_insert('mock_basic',{
        id   => 2,
        name => 'ruby',
    });
    is $mock_basic->name, 'ruby';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    $mock_basic = Mock::Basic->find_or_insert('mock_basic',{
        id   => 2,
        name => 'ruby',
    });
    is $mock_basic->name, 'ruby';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    is +Mock::Basic->count('mock_basic', 'id',{name => 'ruby'}), 1;
    done_testing;
};

done_testing;
