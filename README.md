CISonarqube Cookbook
==================
This cookbook installs and configures Sonarqube as needed for CIInABox on Ubuntu platform machines.


Requirements
------------
Ensure the dependant cookbooks mentioned in metadata are present in the same cookbooks folder. 


Attributes
----------
None

Usage
-----
CISonarqube::default

To include `CISonarqube` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[CISonarqube]"
  ]
}
```


License and Authors
-------------------
Opex Software, Pune