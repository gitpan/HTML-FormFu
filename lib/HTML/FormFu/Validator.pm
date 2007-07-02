package HTML::FormFu::Validator;

use strict;
use warnings;
use base 'HTML::FormFu::Processor';

use HTML::FormFu::Exception::Validator;
use Carp qw/ croak /;

sub process {
    my ( $self, $params ) = @_;

    my $name  = $self->name;
    my $value = $params->{$name};
    my @errors;

    if ( ref $value eq 'ARRAY' ) {
        eval { my @x = @$value };
        croak $@ if $@;

        push @errors, eval {
            $self->validate_values( $value, $params );
        };
        if ( $@ ) {
            push @errors, $self->return_error($@);
        }
    }
    else {
        my $ok = eval {
            $self->validate_value( $value, $params );
        };
        if ( $@ or !$ok ) {
            push @errors, $self->return_error($@);
        }
    }

    return @errors;
}

sub validate_values {
    my ( $self, $values, $params ) = @_;

    my @errors;

    for my $value (@$values) {
        my $ok = eval {
            $self->validate_value( $value, $params );
        };
        if ( blessed $@ && $@->isa('HTML::FormFu::Exception::Validator') ) {
            push @errors, $@;
        }
        elsif ( $@ or !$ok ) {
            push @errors, HTML::FormFu::Exception::Validator->new;
        }
    }

    return @errors;
}

sub validate_value {
    croak "validate() should be overridden";
}

sub return_error {
    my ( $self, $err ) = @_;
    
    if ( !blessed $err || !$err->isa('HTML::FormFu::Exception::Validator') ) {
        $err = HTML::FormFu::Exception::Validator->new;
    }
    
    return $err;
}

1;

__END__

=head1 NAME

HTML::FormFu::Validator - Validator Base Class

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 CORE VALIDATORS

=head1 AUTHOR

Carl Franks, C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.