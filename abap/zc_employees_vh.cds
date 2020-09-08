@AbapCatalog: {
    sqlViewName: 'ZVC_EMPS_VH',
    compiler.compareFilter: true,
    preserveKey: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Employees'
@Search.searchable: true
@OData.publish: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view zc_employees_vh
  as select from SEPM_I_Employee
{
  key Employee,

      @Search: {
        defaultSearchElement: true,
        fuzzinessThreshold: 0.8
      }
      FirstName,

      @Search: {
        defaultSearchElement: true,
        fuzzinessThreshold: 0.8
      }
      LastName
}