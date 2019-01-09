# About

Using the toolsmiths JSON data file, make it easier to access from your local host.

# Usage

Prereqs: `jq` and `om`, both installable with homebrew:

```
brew tap starkandwayne/cf && brew install om jq
```


`bash smithbosh.sh --json="<full path to JSON file"`

it will output export commands, useful if you wrap it in `eval`:

`eval "$(bash ./smithbosh.sh --json="/Users/mcowger/Downloads/maywood.json")"`

Which then lets you run bosh commands easily:

```sh
$ bosh vms
Using environment '10.0.0.5' as client 'ops_manager'

Task 84
Task 83
Task 84 done

Task 83 done

Deployment 'pivotal-container-service-257f357343aaeec4f773'

Instance                                                        Process State  AZ             IPs         VM CID                                   VM Type  Active
pivotal-container-service/fd39f174-fa61-4d7e-87d0-5f2dfea6275d  running        us-central1-f  10.0.10.10  vm-c1617443-0d0f-4c05-7d4b-77f1b1fe34ab  large    true
```
