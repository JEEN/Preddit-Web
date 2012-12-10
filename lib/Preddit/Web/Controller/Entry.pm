package Preddit::Web::Controller::Entry;
use Mojo::Base 'Mojolicious::Controller';
use FormValidator::Lite;
use URI::Find::UTF8;
use utf8;
use Encode;

sub index {
    my $self = shift;

    my $entry = $self->api('Entry')->find_entry({ id => $self->param('entry_id') });
    return $self->render('error_entry') unless $entry;
    $self->stash( entry => $entry );
}

sub entries {
    my $self = shift;

    my $entries = $self->api('Entry')->get_entries();
    $self->stash( entries => $entries );
}

sub add {
    my $self = shift;


}

sub edit {
    my $self = shift;

    my $entry = $self->api('Entry')->find_entry({ id => $self->param('entry_id') });
    return $self->render('error_entry') unless $entry;
    $self->stash( entry => $entry );
}

sub post {
    my $self = shift;

    my $fv = FormValidator::Lite->new($self->req);

    $fv->set_message(
        'title.not_null'       => '제목을 입력해주세요',
        'description.not_null' => '본문을 입력해주세요',
    );

    $fv->check(
   #     title       => [qw/ NOT_NULL /],
        description => [qw/ NOT_NULL /], 
    );

    if ($fv->has_error()) {
        $self->flash( error => 1, messages => [ $fv->get_error_messages() ] );
        if ($self->param('entry_id')) {
            return $self->redirect_to('/entry/'.$self->param('entry_id').'/edit');
        }
        return $self->redirect_to('/entries');
    }


    my $row = {
        title       => $self->param('title') || "",
        description => $self->param('description'),
    };

    my @uris;
    my $finder = URI::Find::UTF8->new(sub {
        my ($uri) = shift;
        push @uris, $uri;
    });
    my $description = $self->param('description');
    $finder->find(\$description);

    $row->{ext_content} = $self->embedly($uris[0]) if scalar @uris;

    if ($self->param('entry_id') && $self->param('_type') && $self->param('_type') eq 'edit') {
        $row->{id}  = $self->param('entry_id');
    }

    my $entry = $self->api('Entry')->update($row);

    $self->flash( ok => 1 , message => '글을 올렸습니다' );
    $self->redirect_to('/entries');
}

1;
