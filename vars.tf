## DATAS ##

variable "resource_group_name" {
  type = string
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "key_vault_key_name" {
  type    = string
  default = null
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "automation_account_name" {
  type    = string
  default = null
}

variable "linked_storage_account_ids" {
  type    = list(string)
  default = null
}

## TAGS ##

variable "tags" {
  type    = map(string)
  default = {}
}

## RESOURCES TO BE CREATED ##

variable "cluster" {
  type = list(object({
    id            = number
    name          = string
    size_gb       = optional(number)
    tags          = optional(map(string))
    identity_type = optional(string)
    identity_ids  = optional(list(string))
  }))
  default = []

  validation {
    condition = length([
      for a in var.cluster : true if contains(["100", "500", "1000", "2000", "5000"], a.size_gb)
    ]) == length(var.cluster)
    error_message = "Possible values include 100, 500, 1000, 2000 or 5000. Defaults to 1000."
  }

  validation {
    condition = length([
      for b in var.cluster : true if contains(["SystemAssigned", "UserAssigned"], b.identity_type)
    ]) == length(var.cluster)
    error_message = "Possible values are SystemAssigned and UserAssigned."
  }
}

variable "cluster_customer_managed_key" {
  type = list(object({
    id         = number
    cluster_id = any
  }))
  default = []
}

variable "data_export_rule" {
  type = list(object({
    id                    = number
    name                  = string
    table_names           = list(string)
    workspace_resource_id = any
    enabled               = optional(bool)
  }))
  default = []
}

variable "datasource_windows_event" {
  type = list(object({
    id             = number
    event_log_name = string
    event_types    = list(string)
    name           = string
    workspace_id   = any
  }))
  default = []

  validation {
    condition = length([
      for a in var.datasource_windows_event : true if contains(["Error", "Warning", "Information"], a.event_types)
    ]) == length(var.datasource_windows_event)
    error_message = "Possible values include Error, Warning and Information."
  }
}

variable "datasource_windows_performance_counter" {
  type = list(object({
    id               = number
    counter_name     = string
    instance_name    = string
    interval_seconds = number
    name             = string
    object_name      = string
    workspace_id     = any
  }))
  default = []

  validation {
    condition = length([
      for a in var.datasource_windows_performance_counter : true if a.interval_seconds >= 10 && a.interval_seconds <= 2147483647
    ]) == length(var.datasource_windows_performance_counter)
    error_message = "Supports values between 10 and 2147483647."
  }
}

variable "linked_service" {
  type = list(object({
    id              = number
    workspace_id    = any
    read_access_id  = optional(string)
    write_access_id = optional(string)
  }))
  default = []
}

variable "linked_storage_account" {
  type = list(object({
    id                    = number
    data_source_type      = string
    workspace_resource_id = any
  }))
  default = []
}

variable "query_pack" {
  type = list(object({
    id   = number
    name = string
    tags = optional(map(string))
  }))
  default = []
}

variable "query_pack_query" {
  type = list(object({
    id                       = number
    body                     = string
    display_name             = string
    query_pack_id            = any
    name                     = optional(string)
    description              = optional(string)
    categories               = optional(list(string))
    additional_settings_json = optional(string)
    resource_types           = optional(list(string))
    solutions                = optional(list(string))
    tags                     = optional(map(string))
  }))
  default = []

  validation {
    condition = length([
      for a in var.query_pack_query : true if contains(["applications", "audit", "container", "databases", "desktopanalytics", "management", "monitor", "network", "resources", "security", "virtualmachines", "windowsvirtualdesktop", "workloads"], a.categories)
    ]) == length(var.query_pack_query)
    error_message = "Possible values are applications, audit, container, databases, desktopanalytics, management, monitor, network, resources, security, virtualmachines, windowsvirtualdesktop and workloads."
  }

  validation {
    condition = length([
      for a in var.query_pack_query : true if contains(["default", "microsoft.aad/domainservices", "microsoft.aadiam/tenants", "microsoft.agfoodplatform/farmbeats", "microsoft.analysisservices/servers", "microsoft.apimanagement/service", "microsoft.appconfiguration/configurationstores", "microsoft.appplatform/spring", "microsoft.attestation/attestationproviders", "microsoft.authorization/tenants", "microsoft.automation/automationaccounts", "microsoft.autonomousdevelopmentplatform/accounts", "microsoft.azurestackhci/virtualmachines", "microsoft.batch/batchaccounts", "microsoft.blockchain/blockchainmembers", "microsoft.botservice/botservices", "microsoft.cache/redis", "microsoft.cdn/profiles", "microsoft.cognitiveservices/accounts", "microsoft.communication/communicationservices", "microsoft.compute/virtualmachines", "microsoft.compute/virtualmachinescalesets", "microsoft.connectedcache/cachenodes", "microsoft.connectedvehicle/platformaccounts", "microsoft.conenctedvmwarevsphere/virtualmachines", "microsoft.containerregistry/registries", "microsoft.containerservice/managedclusters", "microsoft.d365customerinsights/instances", "microsoft.dashboard/grafana", "microsoft.databricks/workspaces", "microsoft.datacollaboration/workspaces", "microsoft.datafactory/factories", "microsoft.datalakeanalytics/accounts", "microsoft.datalakestore/accounts", "microsoft.datashare/accounts", "microsoft.dbformariadb/servers", "microsoft.dbformysql/servers", "microsoft.dbforpostgresql/flexibleservers", "microsoft.dbforpostgresql/servers", "microsoft.dbforpostgresql/serversv2", "microsoft.digitaltwins/digitaltwinsinstances", "microsoft.documentdb/cassandraclusters", "microsoft.documentdb/databaseaccounts", "microsoft.desktopvirtualization/applicationgroups", "microsoft.desktopvirtualization/hostpools", "microsoft.desktopvirtualization/workspaces", "microsoft.devices/iothubs", "microsoft.devices/provisioningservices", "microsoft.dynamics/fraudprotection/purchase", "microsoft.eventgrid/domains", "microsoft.eventgrid/topics", "microsoft.eventgrid/partnernamespaces", "microsoft.eventgrid/partnertopics", "microsoft.eventgrid/systemtopics", "microsoft.eventhub/namespaces", "microsoft.experimentation/experimentworkspaces", "microsoft.hdinsight/clusters", "microsoft.healthcareapis/services", "microsoft.informationprotection/datasecuritymanagement", "microsoft.intune/operations", "microsoft.insights/autoscalesettings", "microsoft.insights/components", "microsoft.insights/workloadmonitoring", "microsoft.keyvault/vaults", "microsoft.kubernetes/connectedclusters", "microsoft.kusto/clusters", "microsoft.loadtestservice/loadtests", "microsoft.logic/workflows", "microsoft.machinelearningservices/workspaces", "microsoft.media/mediaservices", "microsoft.netapp/netappaccounts/capacitypools", "microsoft.network/applicationgateways", "microsoft.network/azurefirewalls", "microsoft.network/bastionhosts", "microsoft.network/expressroutecircuits", "microsoft.network/frontdoors", "microsoft.network/loadbalancers", "microsoft.network/networkinterfaces", "microsoft.network/networksecuritygroups", "microsoft.network/networksecurityperimeters", "microsoft.network/networkwatchers/connectionmonitors", "microsoft.network/networkwatchers/trafficanalytics", "microsoft.network/publicipaddresses", "microsoft.network/trafficmanagerprofiles", "microsoft.network/virtualnetworks", "microsoft.network/virtualnetworkgateways", "microsoft.network/vpngateways", "microsoft.networkfunction/azuretrafficcollectors", "microsoft.openenergyplatform/energyservices", "microsoft.openlogisticsplatform/workspaces", "microsoft.operationalinsights/workspaces", "microsoft.powerbi/tenants", "microsoft.powerbi/tenants/workspaces", "microsoft.powerbidedicated/capacities", "microsoft.purview/accounts", "microsoft.recoveryservices/vaults", "microsoft.resources/azureactivity", "microsoft.scvmm/virtualmachines", "microsoft.search/searchservices", "microsoft.security/antimalwaresettings", "microsoft.securityinsights/amazon", "microsoft.securityinsights/anomalies", "microsoft.securityinsights/cef", "microsoft.securityinsights/datacollection", "microsoft.securityinsights/dnsnormalized", "microsoft.securityinsights/mda", "microsoft.securityinsights/mde", "microsoft.securityinsights/mdi", "microsoft.securityinsights/mdo", "microsoft.securityinsights/networksessionnormalized", "microsoft.securityinsights/office365", "microsoft.securityinsights/purview", "microsoft.securityinsights/securityinsights", "microsoft.securityinsights/securityinsights/mcas", "microsoft.securityinsights/tvm", "microsoft.securityinsights/watchlists", "microsoft.servicebus/namespaces", "microsoft.servicefabric/clusters", "microsoft.signalrservice/signalr", "microsoft.signalrservice/webpubsub", "microsoft.sql/managedinstances", "microsoft.sql/servers", "microsoft.sql/servers/databases", "microsoft.storage/storageaccounts", "microsoft.storagecache/caches", "microsoft.streamanalytics/streamingjobs", "microsoft.synapse/workspaces", "microsoft.timeseriesinsights/environments", "microsoft.videoindexer/accounts", "microsoft.web/sites", "microsoft.workloadmonitor/monitors", "resourcegroup", "subscription"], a.resource_types)
    ]) == length(var.query_pack_query)
    error_message = "Possible values are default, microsoft.aad/domainservices, microsoft.aadiam/tenants, microsoft.agfoodplatform/farmbeats, microsoft.analysisservices/servers, microsoft.apimanagement/service, microsoft.appconfiguration/configurationstores, microsoft.appplatform/spring, microsoft.attestation/attestationproviders, microsoft.authorization/tenants, microsoft.automation/automationaccounts, microsoft.autonomousdevelopmentplatform/accounts, microsoft.azurestackhci/virtualmachines, microsoft.batch/batchaccounts, microsoft.blockchain/blockchainmembers, microsoft.botservice/botservices, microsoft.cache/redis, microsoft.cdn/profiles, microsoft.cognitiveservices/accounts, microsoft.communication/communicationservices, microsoft.compute/virtualmachines, microsoft.compute/virtualmachinescalesets, microsoft.connectedcache/cachenodes, microsoft.connectedvehicle/platformaccounts, microsoft.conenctedvmwarevsphere/virtualmachines, microsoft.containerregistry/registries, microsoft.containerservice/managedclusters, microsoft.d365customerinsights/instances, microsoft.dashboard/grafana, microsoft.databricks/workspaces, microsoft.datacollaboration/workspaces, microsoft.datafactory/factories, microsoft.datalakeanalytics/accounts, microsoft.datalakestore/accounts, microsoft.datashare/accounts, microsoft.dbformariadb/servers, microsoft.dbformysql/servers, microsoft.dbforpostgresql/flexibleservers, microsoft.dbforpostgresql/servers, microsoft.dbforpostgresql/serversv2, microsoft.digitaltwins/digitaltwinsinstances, microsoft.documentdb/cassandraclusters, microsoft.documentdb/databaseaccounts, microsoft.desktopvirtualization/applicationgroups, microsoft.desktopvirtualization/hostpools, microsoft.desktopvirtualization/workspaces, microsoft.devices/iothubs, microsoft.devices/provisioningservices, microsoft.dynamics/fraudprotection/purchase, microsoft.eventgrid/domains, microsoft.eventgrid/topics, microsoft.eventgrid/partnernamespaces, microsoft.eventgrid/partnertopics, microsoft.eventgrid/systemtopics, microsoft.eventhub/namespaces, microsoft.experimentation/experimentworkspaces, microsoft.hdinsight/clusters, microsoft.healthcareapis/services, microsoft.informationprotection/datasecuritymanagement, microsoft.intune/operations, microsoft.insights/autoscalesettings, microsoft.insights/components, microsoft.insights/workloadmonitoring, microsoft.keyvault/vaults, microsoft.kubernetes/connectedclusters, microsoft.kusto/clusters, microsoft.loadtestservice/loadtests, microsoft.logic/workflows, microsoft.machinelearningservices/workspaces, microsoft.media/mediaservices, microsoft.netapp/netappaccounts/capacitypools, microsoft.network/applicationgateways, microsoft.network/azurefirewalls, microsoft.network/bastionhosts, microsoft.network/expressroutecircuits, microsoft.network/frontdoors, microsoft.network/loadbalancers, microsoft.network/networkinterfaces, microsoft.network/networksecuritygroups, microsoft.network/networksecurityperimeters, microsoft.network/networkwatchers/connectionmonitors, microsoft.network/networkwatchers/trafficanalytics, microsoft.network/publicipaddresses, microsoft.network/trafficmanagerprofiles, microsoft.network/virtualnetworks, microsoft.network/virtualnetworkgateways, microsoft.network/vpngateways, microsoft.networkfunction/azuretrafficcollectors, microsoft.openenergyplatform/energyservices, microsoft.openlogisticsplatform/workspaces, microsoft.operationalinsights/workspaces, microsoft.powerbi/tenants, microsoft.powerbi/tenants/workspaces, microsoft.powerbidedicated/capacities, microsoft.purview/accounts, microsoft.recoveryservices/vaults, microsoft.resources/azureactivity, microsoft.scvmm/virtualmachines, microsoft.search/searchservices, microsoft.security/antimalwaresettings, microsoft.securityinsights/amazon, microsoft.securityinsights/anomalies, microsoft.securityinsights/cef, microsoft.securityinsights/datacollection, microsoft.securityinsights/dnsnormalized, microsoft.securityinsights/mda, microsoft.securityinsights/mde, microsoft.securityinsights/mdi, microsoft.securityinsights/mdo, microsoft.securityinsights/networksessionnormalized, microsoft.securityinsights/office365, microsoft.securityinsights/purview, microsoft.securityinsights/securityinsights, microsoft.securityinsights/securityinsights/mcas, microsoft.securityinsights/tvm, microsoft.securityinsights/watchlists, microsoft.servicebus/namespaces, microsoft.servicefabric/clusters, microsoft.signalrservice/signalr, microsoft.signalrservice/webpubsub, microsoft.sql/managedinstances, microsoft.sql/servers, microsoft.sql/servers/databases, microsoft.storage/storageaccounts, microsoft.storagecache/caches, microsoft.streamanalytics/streamingjobs, microsoft.synapse/workspaces, microsoft.timeseriesinsights/environments, microsoft.videoindexer/accounts, microsoft.web/sites, microsoft.workloadmonitor/monitors, resourcegroup and subscription."
  }

  validation {
    condition = length([
      for a in var.query_pack_query : true if contains(["AADDomainServices", "ADAssessment", "ADAssessmentPlus", "ADReplication", "ADSecurityAssessment", "AlertManagement", "AntiMalware", "ApplicationInsights", "AzureAssessment", "AzureSecurityOfThings", "AzureSentinelDSRE", "AzureSentinelPrivatePreview", "BehaviorAnalyticsInsights", "ChangeTracking", "CompatibilityAssessment", "ContainerInsights", "Containers", "CustomizedWindowsEventsFiltering", "DeviceHealthProd", "DnsAnalytics", "ExchangeAssessment", "ExchangeOnlineAssessment", "IISAssessmentPlus", "InfrastructureInsights", "InternalWindowsEvent", "LogManagement", "Microsoft365Analytics", "NetworkMonitoring", "SCCMAssessmentPlus", "SCOMAssessment", "SCOMAssessmentPlus", "Security", "SecurityCenter", "SecurityCenterFree", "SecurityInsights", "ServiceMap", "SfBAssessment", "SfBOnlineAssessment", "SharePointOnlineAssessment", "SPAssessment", "SQLAdvancedThreatProtection", "SQLAssessment", "SQLAssessmentPlus", "SQLDataClassification", "SQLThreatDetection", "SQLVulnerabilityAssessment", "SurfaceHub", "Updates", "VMInsights", "WEFInternalUat", "WEF_10x", "WEF_10xDSRE", "WaaSUpdateInsights", "WinLog", "WindowsClientAssessmentPlus", "WindowsEventForwarding", "WindowsFirewall", "WindowsServerAssessment", "WireData", "WireData2"], a.solutions)
    ]) == length(var.query_pack_query)
    error_message = "Possible values are AADDomainServices, ADAssessment, ADAssessmentPlus, ADReplication, ADSecurityAssessment, AlertManagement, AntiMalware, ApplicationInsights, AzureAssessment, AzureSecurityOfThings, AzureSentinelDSRE, AzureSentinelPrivatePreview, BehaviorAnalyticsInsights, ChangeTracking, CompatibilityAssessment, ContainerInsights, Containers, CustomizedWindowsEventsFiltering, DeviceHealthProd, DnsAnalytics, ExchangeAssessment, ExchangeOnlineAssessment, IISAssessmentPlus, InfrastructureInsights, InternalWindowsEvent, LogManagement, Microsoft365Analytics, NetworkMonitoring, SCCMAssessmentPlus, SCOMAssessment, SCOMAssessmentPlus, Security, SecurityCenter, SecurityCenterFree, SecurityInsights, ServiceMap, SfBAssessment, SfBOnlineAssessment, SharePointOnlineAssessment, SPAssessment, SQLAdvancedThreatProtection, SQLAssessment, SQLAssessmentPlus, SQLDataClassification, SQLThreatDetection, SQLVulnerabilityAssessment, SurfaceHub, Updates, VMInsights, WEFInternalUat, WEF_10x, WEF_10xDSRE, WaaSUpdateInsights, WinLog, WindowsClientAssessmentPlus, WindowsEventForwarding, WindowsFirewall, WindowsServerAssessment, WireData and WireData2."
  }
}

variable "saved_search" {
  type = list(object({
    id                         = number
    category                   = string
    display_name               = string
    log_analytics_workspace_id = any
    name                       = string
    query                      = string
    function_alias             = optional(string)
    function_parameters        = optional(list(string))
    tags                       = optional(map(string))
  }))
  default = []
}

variable "solution" {
  type = list(object({
    id            = number
    solution_name = string
    workspace_id  = any
    tags          = optional(map(string))
    plan = list(object({
      product        = string
      publisher      = string
      promotion_code = optional(string)
    }))
  }))
  default = []
}

variable "workspace" {
  type = list(object({
    id = number
  }))
  default = []
}