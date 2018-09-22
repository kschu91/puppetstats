## 2018-09-22 Release 0.4.0
- Bugfix: Do not show warnings anymore when module is disabled
- Bugfix: Now fail silently when sommething went wrong, before puppet crashed with an error for example when HTTP calls are running into a timeout
- Bugfix: Fixes tests so that they are using the correct puppetversions
- Remove support for puppet 2.7.0 and 3.8.0 - it has never worked anyways


## 2018-03-25 Release 0.3.0
- Feature: Added differentiation for serverless vs. master puppet runs
- Feature: Generate unique system hash based on puppet server name and node name, if not in serverless mode
- Improvement: More resilient behaviour if no version is present
- Improvement: Optimize notices and warnings
- Removed parameter full_qualified_module_name

## 2018-03-24 Release 0.2.0
Feature: support for opt-out with `puppetstats_disabled` fact, which allows to disable puppetstats on a whole server/environment/node

## 2018-03-19 Release 0.1.0
First release supporting basic statistic gathering.