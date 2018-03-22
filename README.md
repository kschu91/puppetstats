# puppetstats

[![Build Status](https://travis-ci.org/kschu91/puppetstats.svg?branch=master)](https://travis-ci.org/kschu91/puppetstats)
[![Puppet Forge](https://img.shields.io/puppetforge/v/kschu91/puppetstats.svg)](https://forge.puppetlabs.com/kschu91/puppetstats)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/kschu91/puppetstats.svg)](https://forge.puppetlabs.com/kschu91/puppetstats)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/kschu91/puppetstats.svg)](https://forge.puppetlabs.com/kschu91/puppetstats)

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

Have you every ask yourself how many systems are using your puppet module in a specific puppet version or on a specific distribution?
This is exactly what [puppetstats.com](https://puppetstats.com) and this module is build for.

This module enables the free service from [puppetstats.com](https://puppetstats.com) that allows you to analyse
anonymous usage statistics of your puppet modules. This can help you to optimize your module based on the usage.

> **Note**: To opt-out completely from puppetstats with your system just follow the [opt-out guide](https://puppetstats.com/opt-out).

## Setup

### What puppetstats affects

The module will send anonymous usage statistics to [puppetstats.com](https://puppetstats.com).
You can sign up for free at [puppetstats.com](https://puppetstats.com) to view and analyse the usage statistics of your modules.

### Beginning with puppetstats

To get started just call the puppetstats module together with the full qualified module name of your puppet module. Eg. `puppetlabs-apache`.

    puppetstats { 'puppetlabs-apache': }
    
After including the puppetstats module into your module, simply go to [puppetstats.com](https://puppetstats.com) and register your module. You can also have a look into the [getting started guide](https://puppetstats.com/getting-started).

## Usage

The common way of including puppetstats in your puppet module, is to give your module users the ability to disable puppetstats if they want to.

    class yourfancymodule (
      Boolean $enable_puppetstats = true,
    ) {
      
      ...
      
      puppetstats { 'puppetlabs-apache': enabled => $enable_puppetstats }
      
      ...
      
    }
    
> **Note**: To disable puppetstats system wide, just follow the [opt-out guide](https://puppetstats.com/opt-out).

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
        full_qualified_module_name => 'puppetlabs-apache',
        enabled => true
    }
... you need to specify `full_qualified_module_name`.

## Limitations

The puppetstats module should work on each OS and distribution where puppet is running.
It has very minimum dependencies and is mostly written in native ruby.

## Development

If you find any defects or want to raise a feature request, [create an issue on Github](https://github.com/kschu91/puppetstats/issues/new) and let me know.