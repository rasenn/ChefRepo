## hadoop-env.sh.erb
default["hadoop"]["java_home"] = "/usr/lib/jvm/default-java"

## core-site.xml.erb
default["hadoop"]["hadoop.tmp.dir"] = "/usr/local/hadoop/datas/tmp"
default["hadoop"]["fs.default.name"] = "file:///usr/local/hadoop/data/name"

## hdfs-site.xml.erb
default["hadoop"]["dfs.replication"] = 1

## mapred-site.xml.erb
default["hadoop"]["mapred.job.tracker"] = "local"
default["hadoop"]["mapred.map.tasks"] = 20
default["hadoop"]["mapred.reduce.tasks"] = 20
default["hadoop"]["mapred.tasktracker.map.tasks.maximum"] = 1
default["hadoop"]["mapred.tasktracker.reduce.tasks.maximum"] = 1


## masters.erb
default["hadoop"]["masters"] = []

## slaves.erb
default["hadoop"]["slaves"] = ["localhost"]

## hosts.erb
default["hadoop"]["hosts"] = [] #[{"ip" => "127.0.0.1","host_name" => "localhost"}]

## user_password
default["hadoop"]["password"] = "hadoop987"
