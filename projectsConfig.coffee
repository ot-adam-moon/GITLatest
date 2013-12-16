config = {}

config.allProjects = ['ProductFulfillment','EnterpriseServices','CustomerFiltering','SpendOnLife','OneTechnologies.Framework']
config.parallelProjects =  ['EnterpriseServices','CustomerFiltering','SpendOnLife','OneTechnologies.Framework', 'ProductFulfillment']
config.dbProjects =  ['EnterpriseServices','CustomerFiltering','SpendOnLife','OneTechnologies.Framework', 'ProductFulfillment']
config.webProjects = ['ProductFulfillment','EnterpriseServices','SpendOnLife']
config.svcProjects = ['ProductFulfillment','EnterpriseServices','CustomerFiltering']
config.projShortcuts = { 'pf': 'ProductFulfillment', 'es' : 'EnterpriseServices' , 'cf': 'CustomerFiltering','spl': 'SpendOnLife', 'otf':'OneTechnologies.Framework'}

module.exports =  config