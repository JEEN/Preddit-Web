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
            $t->get_ok('/entries')->status_is(200)->element_exists('div#pagenator');
        };
    };
    subtest "add" => sub {
        subtest "타이틀 입력이 가능해야 한다" => sub {
            $t->get_ok('/entry/add')->status_is(200)->element_exists('form > input[name="title"]');
        };
        subtest "본문 입력이 가능해야 한다" => sub {
            $t->get_ok('/entry/add')->status_is(200)->element_exists('form > textarea[name="description"]');
        };
        subtest "글을 입력하면 등록된 글의 permalink 로 이동해야 한다" => sub {
            $t->post_form_ok('/entry/add', { 
                title       => "로렘딤섬 #테스트", 
                description => "로렘딤섬 테스트 로렘딤섬 테스트",
            })->status_is(302)->header_like('Location', qr{localhost:\d+\/entry\/\d+$} );
        };
    };
    subtest "edit" => sub {
        subtest "타이틀 수정이 가능해야 한다" => sub {
            $t->get_ok('/entry/1/edit')->status_is(200)->element_exists('form > input[name="title"]');
        };  
        subtest "본문 수정이 가능해야 한다" => sub {
            $t->get_ok('/entry/1/edit')->status_is(200)->element_exists('form > textarea[name="description"]');
        };
        subtest "글을 수정하면 등록된 글의 permalink 로 이동해야 한다" => sub {
            $t->post_form_ok('/entry/1/edit', {
                title       => "로렘딤섬 #테스트 edit",
                description => "로렘딤섬 테스트 로렘딤섬 테스트 edit"
            })->status_is(302)->header_like('Location', qr{localhost:\d+\/entry\/\d+$} );
        }
    };
};

done_testing();
