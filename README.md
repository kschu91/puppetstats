# puppetstats

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with puppetstats](#setup)
    * [What puppetstats affects](#what-puppetstats-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppetstats](#beginning-with-puppetstats)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Have you every ask yourself how many people are using your module in a specific puppet version or on a specific distribution?
This is exactly what [puppetstats.com](https://puppetstats.com) and this module is build for.

This module enables the free service from [puppetstats.com](https://puppetstats.com). [puppetstats.com](https://puppetstats.com) allows to analyse
anonymous usage statistics of puppet modules which can help you to optimize your module based on the usage.
The puppetstats module is required to gather statistics about you module.

## Setup

### What puppetstats affects

When included, puppetstats module will send anonymous usage statistics to [puppetstats.com](https://puppetstats.com).
You can sign up for free at [puppetstats.com](https://puppetstats.com) to see and analyse the statistics of your modules.

### Beginning with puppetstats

To get started just call the puppetstats module together with the full qualified module name of your puppet module. Eg. `puppetlabs-apache`.

    puppetstats { 'puppetlabs-apache': }

## Usage

This is the common way of including puppetstats in your puppet module.

    class yourfancymodule (
      Boolean $enable_puppetstats = true,
    ) {
      
      ...
      
      puppetstats { 'puppetlabs-apache': enabled => $enable_puppetstats }
      
      ...
      
    }

## Reference

### enabled

    puppetstats { 'puppetlabs-apache': enabled => false}

Which allows you to disable the tracking of statistics. This parameter is useful if you want to give the users of your
module the ability to disable puppetstats statistics. For example:

    class yourfancymodule (
      Boolean $enable_puppetstats = true,
    ) {
      
      ...
      
      puppetstats { 'puppetlabs-apache': enabled => $enable_puppetstats }
      
      ...
      
    }

### full_qualified_module_name

The `full_qualified_module_name` is filled with `$title` by default, which means when you use it like this:

    puppetstats { 'puppetlabs-apache': }
    
... you do not need to specify `full_qualified_module_name` explicitly.

However, if you want to use puppetstats like this:

    class { '::puppetstats':
        full_qualified_module_name => 'company',
        enabled => true
    }
... you need to specify `full_qualified_module_name`.

## Limitations

The puppetstats module should work on each OS and distribution where puppet is running.
It has minimum dependencies and is mostly written in native ruby.

## Development

If you find any defects or want to raise a feature request, [create an issue on Github](https://github.com/kschu91/puppetstats/issues/new) and let me know.