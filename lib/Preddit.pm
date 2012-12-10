package Preddit;
use Mojo::Base 'Mojolicious';
use Preddit::API;
use WebService::Embedly;

sub startup {
    my $app = shift;

    my $config = $app->plugin('Config', { file => 'preddit.conf' });

    my $_api = Preddit::API->new( $config->{db} );
    $app->helper( api => sub { $_api->find($_[1]) } );

    my $embedly = WebService::Embedly->new({ 
        api_key => $config->{plugin}->{embedly}->{api_key},
        maxwidth => $config->{plugin}->{embedly}->{max_width},
    });

    $app->helper( embedly => sub {
        return $embedly->oembed($_[1]);
    });
    
    $app->hook( before_dispatch => sub {
        my $c = shift;

        map { $c->stash->{$_} = $c->flash($_) } grep { $c->flash($_) } 
            qw/error message messages/;
    });

    # Router
    my $r = $app->routes;
    $r->namespace(__PACKAGE__ .'::Web::Controller');
    # Normal route to controller
    $r->route('/entry/add')->via('get')->to('Entry#add');
    $r->route('/entry/add')->via('post')->to('Entry#post');
    $r->route('/entry/:entry_id/edit')->via('get')->to('Entry#edit');
    $r->route('/entry/:entry_id/edit')->via('post')->to('Entry#post');
    $r->route('/entry/:entry_id')->to('Entry#index');
    $r->route('/entries')->to('Entry#entries');
}

1;
