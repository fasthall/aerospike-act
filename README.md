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

It can take an hour. (only need to run it once for all the tests)
```
ssd-act$ docker run -it --rm --privileged --device /dev/nvme0n1 fasthall/aerospike-act ./actprep /dev/nvme0n1
```

**Run the test in background**
```
ssd-act$ docker run -d --name act --device /dev/nvme0n1 fasthall/aerospike-act sh -c "./act actconfig_6x_1d.txt > output.txt"
```

**Monitor the progress**
```
ssd-act$ docker exec act tail -f /act/output.txt
```

**Copy the result**
```
ssd-act$ docker cp act:/act/output.txt ./
```
