## 2018-03-25 Release 0.3.0
- Feature: Added differentiation for serverless vs. master puppet runs
- Feature: Generate unique system hash based on puppet server name and node name, if not in serverless mode
- Improvement: More resilient behaviour if no version is present
- Improvement: Optimize notices and warnings

## 2018-03-24 Release 0.2.0
Feature: support for opt-out with `puppetstats_disabled` fact, which allows to disable puppetstats on a whole server/environment/node

## 2018-03-19 Release 0.1.0
First release supporting basic statistic gathering.