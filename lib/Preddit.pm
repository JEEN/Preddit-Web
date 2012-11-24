package Preddit;
use Mojo::Base 'Mojolicious';
use Preddit::API;

sub startup {
    my $app = shift;

    my $config = $app->plugin('Config', { file => 'preddit.conf' });

    my $_api = Preddit::API->new( $config->{db} );
    $app->helper( api => sub { $_api->find($_[1]) } );

    # Router
    my $r = $app->routes;
    $r->namespace(__PACKAGE__ .'::Web::Controller');
    # Normal route to controller
    $r->route('/entry/:id')->to('Entry#index');
    $r->route('/entries')->to('Entry#entries');
    $r->route('/entry/add')->to('Entry#add');
    $r->route('/entry/:id/edit')->to('Entry#edit');

}

1;
