## DATAS ##

variable "resource_group_name" {
  type = string
}

## TAGS ##

variable "tags" {
  type    = map(string)
  default = {}
}

## RESOURCES TO BE CREATED ##

variable "cluster" {
  type = list(object({
    name          = string
    size_gb       = optional(number)
    tags          = optional(map(string))
    identity_type = optional(string)
    identity_ids  = optional(list(string))
    managed_key   = optional(object({
      key_vault_key_id = string
    }))
  }))
  default = []

  validation {
    condition     = alltrue([for a in var.cluster : true if contains(["100", "500", "1000", "2000", "5000"], a.size_gb)])
    error_message = "Possible values include 100, 500, 1000, 2000 or 5000. Defaults to 1000."
  }

  validation {
    condition     = alltrue([for b in var.cluster : true if contains(["SystemAssigned", "UserAssigned"], b.identity_type)])
    error_message = "Possible values are SystemAssigned and UserAssigned."
  }
}

variable "workspace" {
  type = list(object({
    name                                    = string
    allow_resource_only_permissions         = optional(bool)
    local_authentication_disabled           = optional(bool)
    sku                                     = optional(string)
    reservation_capacity_in_gb_per_day      = optional(number)
    retention_in_days                       = optional(number)
    daily_quota_gb                          = optional(number)
    data_collection_rule_id                 = optional(string)
    cmk_for_query_forced                    = optional(bool)
    internet_ingestion_enabled              = optional(bool)
    internet_query_enabled                  = optional(bool)
    immediate_data_purge_on_30_days_enabled = optional(string)
    tags                                    = optional(map(string))
    identity_type                           = optional(string)
    identity_ids                            = optional(list(string))
    export_rule = optional(list(object({
      name                    = string
      table_names             = list(string)
      enabled                 = optional(bool)
      destination_resource_id = string
    })))
    windows_event = optional(list(object({
      event_log_name = string
      event_types    = list(string)
      name           = string
    })))
    windows_performance_counter = optional(list(object({
      counter_name     = string
      instance_name    = string
      interval_seconds = number
      name             = string
      object_name      = string
    })))
    linked_service = optional(list(object({
      write_access_id = string
      read_access_id  = string
    })))
    linked_storage_account = optional(list(object({
      data_source_type    = string
      storage_account_ids = string
    })))
    saved_search = optional(list(object({
      category            = string
      display_name        = string
      name                = string
      query               = string
      function_alias      = optional(string)
      function_parameters = optional(list(string))
      tags                = optional(map(string))
    })))
    solution = optional(list(object({
      solution_name  = string
      tags           = optional(map(string))
      product        = string
      publisher      = string
      promotion_code = optional(string)
    })))
    storage_insights = optional(list(object({
      name                 = string
      blob_container_names = optional(set(string))
      table_names          = optional(set(string))
    })))
    table = optional(list(object({
      name                    = string
      plan                    = optional(string)
      retention_in_days       = optional(number)
      total_retention_in_days = optional(number)
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for a in var.workspace : true if contains(["PerNode", "Premium", "Standard", "Standalone", "Unlimited", "CapacityReservation", "PerGB2018"], a.sku)])
    error_message = "Possible values are PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018."
  }

  validation {
    condition     = alltrue([for b in var.workspace : true if contains(["100", "200", "300", "400", "500", "1000", "2000", "5000"], b.reservation_capacity_in_gb_per_day)])
    error_message = "Possible values are 100, 200, 300, 400, 500, 1000, 2000 and 5000."
  }

  validation {
    condition     = alltrue([for b in var.workspace : true if contains(["SystemAssigned", "UserAssigned"], b.identity_type)])
    error_message = "Possible values are SystemAssigned (where Azure will generate a Service Principal for you) and UserAssigned where you can specify the Service Principal IDs in the identity_ids field."
  }

  validation {
    condition     = alltrue([for a in var.workspace.*.windows_event : true if contains(["Error", "Warning", "Information"], a[0].event_types)])
    error_message = "Possible values include Error, Warning and Information."
  }

  validation {
    condition     = alltrue([for a in var.workspace.*.windows_performance_counter : true if a[0].interval_seconds >= 10 && a[0].interval_seconds <= 2147483647])
    error_message = "Supports values between 10 and 2147483647."
  }

  validation {
    condition     = alltrue([for a in var.workspace.*.table : true if contains(["Analytics", "Basic"], a[0].plan)])
    error_message = "Possible values are Analytics and Basic. Defaults to Analytics."
  }

  validation {
    condition     = alltrue([for b in var.workspace.*.table : true if b[0].retention_in_days == 7 || b[0].retention_in_days >= 30 && b[0].retention_in_days <= 730])
    error_message = "Possible values are either 7 (Free Tier only) or range between 30 and 730."
  }

  validation {
    condition     = alltrue([for c in var.workspace.*.table : true if c[0].retention_in_days >= 30 && c[0].retention_in_days <= 4383])
    error_message = "Possible values range between 30 and 4383."
  }
}

variable "query_pack" {
  type = list(object({
    id   = number
    name = string
    tags = optional(map(string))
    pack = optional(list(object({
      body                     = string
      display_name             = string
      name                     = optional(string)
      description              = optional(string)
      categories               = optional(list(string))
      additional_settings_json = optional(string)
      resource_types           = optional(list(string))
      solutions                = optional(list(string))
      tags                     = optional(map(string))
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for a in var.query_pack.*.pack : true if contains(["applications", "audit", "container", "databases", "desktopanalytics", "management", "monitor", "network", "resources", "security", "virtualmachines", "windowsvirtualdesktop", "workloads"], a[0].categories)])
    error_message = "Possible values are applications, audit, container, databases, desktopanalytics, management, monitor, network, resources, security, virtualmachines, windowsvirtualdesktop and workloads."
  }

  validation {
    condition     = alltrue([for b in var.query_pack.*.pack : true if contains(["default", "microsoft.aad/domainservices", "microsoft.aadiam/tenants", "microsoft.agfoodplatform/farmbeats", "microsoft.analysisservices/servers", "microsoft.apimanagement/service", "microsoft.appconfiguration/configurationstores", "microsoft.appplatform/spring", "microsoft.attestation/attestationproviders", "microsoft.authorization/tenants", "microsoft.automation/automationaccounts", "microsoft.autonomousdevelopmentplatform/accounts", "microsoft.azurestackhci/virtualmachines", "microsoft.batch/batchaccounts", "microsoft.blockchain/blockchainmembers", "microsoft.botservice/botservices", "microsoft.cache/redis", "microsoft.cdn/profiles", "microsoft.cognitiveservices/accounts", "microsoft.communication/communicationservices", "microsoft.compute/virtualmachines", "microsoft.compute/virtualmachinescalesets", "microsoft.connectedcache/cachenodes", "microsoft.connectedvehicle/platformaccounts", "microsoft.conenctedvmwarevsphere/virtualmachines", "microsoft.containerregistry/registries", "microsoft.containerservice/managedclusters", "microsoft.d365customerinsights/instances", "microsoft.dashboard/grafana", "microsoft.databricks/workspaces", "microsoft.datacollaboration/workspaces", "microsoft.datafactory/factories", "microsoft.datalakeanalytics/accounts", "microsoft.datalakestore/accounts", "microsoft.datashare/accounts", "microsoft.dbformariadb/servers", "microsoft.dbformysql/servers", "microsoft.dbforpostgresql/flexibleservers", "microsoft.dbforpostgresql/servers", "microsoft.dbforpostgresql/serversv2", "microsoft.digitaltwins/digitaltwinsinstances", "microsoft.documentdb/cassandraclusters", "microsoft.documentdb/databaseaccounts", "microsoft.desktopvirtualization/applicationgroups", "microsoft.desktopvirtualization/hostpools", "microsoft.desktopvirtualization/workspaces", "microsoft.devices/iothubs", "microsoft.devices/provisioningservices", "microsoft.dynamics/fraudprotection/purchase", "microsoft.eventgrid/domains", "microsoft.eventgrid/topics", "microsoft.eventgrid/partnernamespaces", "microsoft.eventgrid/partnertopics", "microsoft.eventgrid/systemtopics", "microsoft.eventhub/namespaces", "microsoft.experimentation/experimentworkspaces", "microsoft.hdinsight/clusters", "microsoft.healthcareapis/services", "microsoft.informationprotection/datasecuritymanagement", "microsoft.intune/operations", "microsoft.insights/autoscalesettings", "microsoft.insights/components", "microsoft.insights/workloadmonitoring", "microsoft.keyvault/vaults", "microsoft.kubernetes/connectedclusters", "microsoft.kusto/clusters", "microsoft.loadtestservice/loadtests", "microsoft.logic/workflows", "microsoft.machinelearningservices/workspaces", "microsoft.media/mediaservices", "microsoft.netapp/netappaccounts/capacitypools", "microsoft.network/applicationgateways", "microsoft.network/azurefirewalls", "microsoft.network/bastionhosts", "microsoft.network/expressroutecircuits", "microsoft.network/frontdoors", "microsoft.network/loadbalancers", "microsoft.network/networkinterfaces", "microsoft.network/networksecuritygroups", "microsoft.network/networksecurityperimeters", "microsoft.network/networkwatchers/connectionmonitors", "microsoft.network/networkwatchers/trafficanalytics", "microsoft.network/publicipaddresses", "microsoft.network/trafficmanagerprofiles", "microsoft.network/virtualnetworks", "microsoft.network/virtualnetworkgateways", "microsoft.network/vpngateways", "microsoft.networkfunction/azuretrafficcollectors", "microsoft.openenergyplatform/energyservices", "microsoft.openlogisticsplatform/workspaces", "microsoft.operationalinsights/workspaces", "microsoft.powerbi/tenants", "microsoft.powerbi/tenants/workspaces", "microsoft.powerbidedicated/capacities", "microsoft.purview/accounts", "microsoft.recoveryservices/vaults", "microsoft.resources/azureactivity", "microsoft.scvmm/virtualmachines", "microsoft.search/searchservices", "microsoft.security/antimalwaresettings", "microsoft.securityinsights/amazon", "microsoft.securityinsights/anomalies", "microsoft.securityinsights/cef", "microsoft.securityinsights/datacollection", "microsoft.securityinsights/dnsnormalized", "microsoft.securityinsights/mda", "microsoft.securityinsights/mde", "microsoft.securityinsights/mdi", "microsoft.securityinsights/mdo", "microsoft.securityinsights/networksessionnormalized", "microsoft.securityinsights/office365", "microsoft.securityinsights/purview", "microsoft.securityinsights/securityinsights", "microsoft.securityinsights/securityinsights/mcas", "microsoft.securityinsights/tvm", "microsoft.securityinsights/watchlists", "microsoft.servicebus/namespaces", "microsoft.servicefabric/clusters", "microsoft.signalrservice/signalr", "microsoft.signalrservice/webpubsub", "microsoft.sql/managedinstances", "microsoft.sql/servers", "microsoft.sql/servers/databases", "microsoft.storage/storageaccounts", "microsoft.storagecache/caches", "microsoft.streamanalytics/streamingjobs", "microsoft.synapse/workspaces", "microsoft.timeseriesinsights/environments", "microsoft.videoindexer/accounts", "microsoft.web/sites", "microsoft.workloadmonitor/monitors", "resourcegroup", "subscription"], b[0].resource_types)])
    error_message = "Possible values are default, microsoft.aad/domainservices, microsoft.aadiam/tenants, microsoft.agfoodplatform/farmbeats, microsoft.analysisservices/servers, microsoft.apimanagement/service, microsoft.appconfiguration/configurationstores, microsoft.appplatform/spring, microsoft.attestation/attestationproviders, microsoft.authorization/tenants, microsoft.automation/automationaccounts, microsoft.autonomousdevelopmentplatform/accounts, microsoft.azurestackhci/virtualmachines, microsoft.batch/batchaccounts, microsoft.blockchain/blockchainmembers, microsoft.botservice/botservices, microsoft.cache/redis, microsoft.cdn/profiles, microsoft.cognitiveservices/accounts, microsoft.communication/communicationservices, microsoft.compute/virtualmachines, microsoft.compute/virtualmachinescalesets, microsoft.connectedcache/cachenodes, microsoft.connectedvehicle/platformaccounts, microsoft.conenctedvmwarevsphere/virtualmachines, microsoft.containerregistry/registries, microsoft.containerservice/managedclusters, microsoft.d365customerinsights/instances, microsoft.dashboard/grafana, microsoft.databricks/workspaces, microsoft.datacollaboration/workspaces, microsoft.datafactory/factories, microsoft.datalakeanalytics/accounts, microsoft.datalakestore/accounts, microsoft.datashare/accounts, microsoft.dbformariadb/servers, microsoft.dbformysql/servers, microsoft.dbforpostgresql/flexibleservers, microsoft.dbforpostgresql/servers, microsoft.dbforpostgresql/serversv2, microsoft.digitaltwins/digitaltwinsinstances, microsoft.documentdb/cassandraclusters, microsoft.documentdb/databaseaccounts, microsoft.desktopvirtualization/applicationgroups, microsoft.desktopvirtualization/hostpools, microsoft.desktopvirtualization/workspaces, microsoft.devices/iothubs, microsoft.devices/provisioningservices, microsoft.dynamics/fraudprotection/purchase, microsoft.eventgrid/domains, microsoft.eventgrid/topics, microsoft.eventgrid/partnernamespaces, microsoft.eventgrid/partnertopics, microsoft.eventgrid/systemtopics, microsoft.eventhub/namespaces, microsoft.experimentation/experimentworkspaces, microsoft.hdinsight/clusters, microsoft.healthcareapis/services, microsoft.informationprotection/datasecuritymanagement, microsoft.intune/operations, microsoft.insights/autoscalesettings, microsoft.insights/components, microsoft.insights/workloadmonitoring, microsoft.keyvault/vaults, microsoft.kubernetes/connectedclusters, microsoft.kusto/clusters, microsoft.loadtestservice/loadtests, microsoft.logic/workflows, microsoft.machinelearningservices/workspaces, microsoft.media/mediaservices, microsoft.netapp/netappaccounts/capacitypools, microsoft.network/applicationgateways, microsoft.network/azurefirewalls, microsoft.network/bastionhosts, microsoft.network/expressroutecircuits, microsoft.network/frontdoors, microsoft.network/loadbalancers, microsoft.network/networkinterfaces, microsoft.network/networksecuritygroups, microsoft.network/networksecurityperimeters, microsoft.network/networkwatchers/connectionmonitors, microsoft.network/networkwatchers/trafficanalytics, microsoft.network/publicipaddresses, microsoft.network/trafficmanagerprofiles, microsoft.network/virtualnetworks, microsoft.network/virtualnetworkgateways, microsoft.network/vpngateways, microsoft.networkfunction/azuretrafficcollectors, microsoft.openenergyplatform/energyservices, microsoft.openlogisticsplatform/workspaces, microsoft.operationalinsights/workspaces, microsoft.powerbi/tenants, microsoft.powerbi/tenants/workspaces, microsoft.powerbidedicated/capacities, microsoft.purview/accounts, microsoft.recoveryservices/vaults, microsoft.resources/azureactivity, microsoft.scvmm/virtualmachines, microsoft.search/searchservices, microsoft.security/antimalwaresettings, microsoft.securityinsights/amazon, microsoft.securityinsights/anomalies, microsoft.securityinsights/cef, microsoft.securityinsights/datacollection, microsoft.securityinsights/dnsnormalized, microsoft.securityinsights/mda, microsoft.securityinsights/mde, microsoft.securityinsights/mdi, microsoft.securityinsights/mdo, microsoft.securityinsights/networksessionnormalized, microsoft.securityinsights/office365, microsoft.securityinsights/purview, microsoft.securityinsights/securityinsights, microsoft.securityinsights/securityinsights/mcas, microsoft.securityinsights/tvm, microsoft.securityinsights/watchlists, microsoft.servicebus/namespaces, microsoft.servicefabric/clusters, microsoft.signalrservice/signalr, microsoft.signalrservice/webpubsub, microsoft.sql/managedinstances, microsoft.sql/servers, microsoft.sql/servers/databases, microsoft.storage/storageaccounts, microsoft.storagecache/caches, microsoft.streamanalytics/streamingjobs, microsoft.synapse/workspaces, microsoft.timeseriesinsights/environments, microsoft.videoindexer/accounts, microsoft.web/sites, microsoft.workloadmonitor/monitors, resourcegroup and subscription."
  }

  validation {
    condition     = alltrue([for c in var.query_pack.*.pack : true if contains(["AADDomainServices", "ADAssessment", "ADAssessmentPlus", "ADReplication", "ADSecurityAssessment", "AlertManagement", "AntiMalware", "ApplicationInsights", "AzureAssessment", "AzureSecurityOfThings", "AzureSentinelDSRE", "AzureSentinelPrivatePreview", "BehaviorAnalyticsInsights", "ChangeTracking", "CompatibilityAssessment", "ContainerInsights", "Containers", "CustomizedWindowsEventsFiltering", "DeviceHealthProd", "DnsAnalytics", "ExchangeAssessment", "ExchangeOnlineAssessment", "IISAssessmentPlus", "InfrastructureInsights", "InternalWindowsEvent", "LogManagement", "Microsoft365Analytics", "NetworkMonitoring", "SCCMAssessmentPlus", "SCOMAssessment", "SCOMAssessmentPlus", "Security", "SecurityCenter", "SecurityCenterFree", "SecurityInsights", "ServiceMap", "SfBAssessment", "SfBOnlineAssessment", "SharePointOnlineAssessment", "SPAssessment", "SQLAdvancedThreatProtection", "SQLAssessment", "SQLAssessmentPlus", "SQLDataClassification", "SQLThreatDetection", "SQLVulnerabilityAssessment", "SurfaceHub", "Updates", "VMInsights", "WEFInternalUat", "WEF_10x", "WEF_10xDSRE", "WaaSUpdateInsights", "WinLog", "WindowsClientAssessmentPlus", "WindowsEventForwarding", "WindowsFirewall", "WindowsServerAssessment", "WireData", "WireData2"], c[0].solutions)])
    error_message = "Possible values are AADDomainServices, ADAssessment, ADAssessmentPlus, ADReplication, ADSecurityAssessment, AlertManagement, AntiMalware, ApplicationInsights, AzureAssessment, AzureSecurityOfThings, AzureSentinelDSRE, AzureSentinelPrivatePreview, BehaviorAnalyticsInsights, ChangeTracking, CompatibilityAssessment, ContainerInsights, Containers, CustomizedWindowsEventsFiltering, DeviceHealthProd, DnsAnalytics, ExchangeAssessment, ExchangeOnlineAssessment, IISAssessmentPlus, InfrastructureInsights, InternalWindowsEvent, LogManagement, Microsoft365Analytics, NetworkMonitoring, SCCMAssessmentPlus, SCOMAssessment, SCOMAssessmentPlus, Security, SecurityCenter, SecurityCenterFree, SecurityInsights, ServiceMap, SfBAssessment, SfBOnlineAssessment, SharePointOnlineAssessment, SPAssessment, SQLAdvancedThreatProtection, SQLAssessment, SQLAssessmentPlus, SQLDataClassification, SQLThreatDetection, SQLVulnerabilityAssessment, SurfaceHub, Updates, VMInsights, WEFInternalUat, WEF_10x, WEF_10xDSRE, WaaSUpdateInsights, WinLog, WindowsClientAssessmentPlus, WindowsEventForwarding, WindowsFirewall, WindowsServerAssessment, WireData and WireData2."
  }
}