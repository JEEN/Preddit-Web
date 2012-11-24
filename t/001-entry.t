use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use utf8;

my $t = Test::Mojo->new('Preddit');

subtest "Entry" => sub {
    subtest "index" => sub {
        subtest "등록된 엔트리의 타이틀이 표시되어야 한다" => sub {
            $t->get_ok("/entry/1")->status_is(200)->element_exists('div#title');
        };
        subtest "등록된 엔트리의 내용이 표시되어야 한다" => sub {
            $t->get_ok("/entry/1")->status_is(200)->element_exists('div#description');
        };
        subtest "등록된 엔트리의 등록일자가 표시되어야 한다" => sub {
            $t->get_ok("/entry/1")->status_is(200)->element_exists('div#date');
        };
    };
    subtest "entries" => sub {
        subtest "등록된 엔트리의 리스트가 표시되어야 한다" => sub {
            $t->get_ok('/entries')->status_is(200)->element_exists('div#entries');
        };
        subtest "Pagenator 가 표시되어야 한다" => sub {
            $t->get_ok('/entires')->status_is(200)->element_exists('div#pagenator');
        };
    };
    subtest "add" => sub {

    };
};

done_testing();
