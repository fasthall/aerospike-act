# Aerospike-ACT

This image contains the [Aerospike's ACT](https://github.com/aerospike/act) tool. Please refer to the repo to see the usage.

To run the tool against a GCP local SSD, use the following commands.

**Create an instance with a local SSD attached**

```
$ gcloud compute instances create ssd-act \
    --machine-type n1-standard-8 \
    --local-ssd interface=nvme \
    --image-project ubuntu-os-cloud \
    --image-family ubuntu-1604-lts
```

**SSH into the instance**

```
$ gcloud compute ssh ssd-act
```

**Prepare the SSD**

```
ssd-act$ docker run -it --rm --privileged --device DEVICE fasthall/aerospike-act ./actprep DEVICE
```

It can take an hour. (only need to run it once for all the tests)

**Run the test in background**

```
ssd-act$ docker run -d --name act --device DEVICE fasthall/aerospike-act sh run.sh DEVICE CONFIG_TEMPLATE
```

Find the config file named config_xx_xx.txt in this directory and replace CONFIG with the filename in the command.

**Monitor the progress**

```
ssd-act$ docker exec act tail -f /act/output.txt
```

**Copy the result**

```
ssd-act$ docker cp act:/act/output.txt ./
```

**Analyze the result**

```
$ $ACT_REPO/latency_calc/act_latency.py -l output.txt
```
