
## Zabbix监控的流程
Zabbix Server 根据Item（监控项）的Interval从Zabbix Agent获取数据，当Item受到新的数据时，如果有Trigger（触发器）与之关联，那么Zabbix就会根据item的值检查这个Trigger，得出的结果会生成一个Event（事件），如果有符合要求的Action（报警动作），那么就要进行Action中定义的操作。


