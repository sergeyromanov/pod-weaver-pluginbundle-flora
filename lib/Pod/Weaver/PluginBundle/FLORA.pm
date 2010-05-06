use strict;
use warnings;

package Pod::Weaver::PluginBundle::FLORA;
# ABSTRACT: Document your modules like FLORA does

use Pod::Weaver::Config::Assembler;

sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }

use namespace::clean;

=head1 SYNOPSIS

In weaver.ini:

  [@FLORA]

or in dist.ini:

  [PodWeaver]
  config_plugin = @FLORA

=head1 OVERVIEW

This plugin bundle is equivalent to the following weaver.ini file:

  [@CorePrep]

  [Name]

  [Region / prelude]

  [Generic / SYNOPSIS]
  [Generic / DESCRIPTION]
  [Generic / OVERVIEW]

  [Collect / ATTRIBUTES]
  command = attr

  [Collect / METHODS]
  command = method

  [Collect / FUNCTIONS]
  command = func

  [Leftovers]

  [Region / postlude]

  [Authors]
  [Legal]

  [-Transformer]
  transformer = List

=begin Pod::Coverage

mvp_bundle_config

=end Pod::Coverage

=cut

sub mvp_bundle_config {
    return (
        [ '@FLORA/CorePrep',  _exp('@CorePrep'),    {} ],
        [ '@FLORA/Name',      _exp('Name'),         {} ],
        [ '@FLORA/prelude',   _exp('Region'),       { region_name => 'prelude' } ],
        
        [ 'SYNOPSIS',         _exp('Generic'),      {} ],
        [ 'DESCRIPTION',      _exp('Generic'),      {} ],
        [ 'OVERVIEW',         _exp('Generic'),      {} ],

        [ 'ATTRIBUTES',       _exp('Collect'),      { command => 'attr'   } ],
        [ 'METHODS',          _exp('Collect'),      { command => 'method' } ],
        [ 'FUNCTIONS',        _exp('Collect'),      { command => 'func'   } ],

        [ '@FLORA/Leftovers', _exp('Leftovers'),    {} ],

        [ '@FLORA/postlude',  _exp('Region'),       { region_name => 'postlude' } ],

        [ '@FLORA/Authors',   _exp('Authors'),      {} ],
        [ '@FLORA/Legal',     _exp('Legal'),        {} ],

        [ '@FLORA/List',      _exp('-Transformer'), { transformer => 'List' } ],
    );
}

1;
