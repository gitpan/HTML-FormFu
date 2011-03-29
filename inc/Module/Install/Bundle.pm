#line 1
package Module::Install::Bundle;

use strict;
use File::Spec;
use Module::Install::Base ();

use vars qw{$VERSION @ISA $ISCORE};
BEGIN {
	$VERSION = '1.00';
	@ISA     = 'Module::Install::Base';
	$ISCORE  = 1;
}

sub auto_bundle {
    my $self = shift;

    return $self->_install_bundled_dists unless $self->is_admin;

    # Flatten array of arrays into a single array
    my @core = map @$_, map @$_, grep ref, $self->requires;

    $self->bundle(@core);
}

sub bundle {
    my $self = shift;

    return $self->_install_bundled_dists unless $self->is_admin;

    $self->admin->bundle(@_);
}

sub auto_bundle_deps {
    my $self = shift;

    return $self->_install_bundled_dists unless $self->is_admin;

    # Flatten array of arrays into a single array
    my @core = map @$_, map @$_, grep ref, $self->requires;
    while (my ($name, $version) = splice(@core, 0, 2)) {
        next unless $name;
         $self->bundle_deps($name, $version);
    }
}

sub bundle_deps {
    my ($self, $pkg, $version) = @_;

    return $self->_install_bundled_dists unless $self->is_admin;

    my $deps = $self->admin->scan_dependencies($pkg);
    if (scalar keys %$deps == 0) {
        # Probably a user trying to install the package, read the dependencies from META.yml
        %$deps = ( map { $$_[0] => undef } (@{$self->requires()}) );
    }
    foreach my $key (sort keys %$deps) {
        $self->bundle($key, ($key eq $pkg) ? $version : 0);
    }
}

sub _install_bundled_dists {
    my $self = shift;

    # process bundle only the first time this function is called
    return if $self->{bundle_processed};

    $self->makemaker_args->{DIR} ||= [];

    # process all dists bundled in inc/BUNDLES/
    my $bundle_dir = $self->_top->{bundle};
    foreach my $sub_dir (glob File::Spec->catfile($bundle_dir,"*")) {

        next if -f $sub_dir;

        # ignore dot dirs/files if any
        my $dot_file = File::Spec->catfile($bundle_dir,'\.');
        next if index($sub_dir, $dot_file) >= $[;

        # EU::MM can't handle Build.PL based distributions
        if (-f File::Spec->catfile($sub_dir, 'Build.PL')) {
            warn "Skipped: $sub_dir has Build.PL.";
            next;
        }

        # EU::MM can't handle distributions without Makefile.PL
        # (actually this is to cut blib in a wrong directory)
        if (!-f File::Spec->catfile($sub_dir, 'Makefile.PL')) {
            warn "Skipped: $sub_dir has no Makefile.PL.";
            next;
        }
        push @{ $self->makemaker_args->{DIR} }, $sub_dir;
    }

    $self->{bundle_processed} = 1;
}

1;

__END__

#line 195
