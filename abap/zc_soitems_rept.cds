@AbapCatalog: {
    sqlViewName: 'ZVC_SOITEMS_REPT',
    compiler.compareFilter: true,
    preserveKey: true
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Lines Report'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
@UI.headerInfo: {
    typeName: 'Sales Order Item',
    typeNamePlural: 'Sales Order Items'
}
@Search.searchable: true
define view zc_soitems_rept
  as select distinct from SEPM_I_SalesOrderItem
    inner join            SEPM_I_Product on SEPM_I_SalesOrderItem.ProductUUID = SEPM_I_Product.ProductUUID
  association [0..1] to zc_employees_vh as _Employees on $projection.employee = _Employees.Employee
{
      @UI: {
        selectionField.position: 10,
        lineItem.position: 10
      }
  key _SalesOrder.SalesOrder,

      @UI.lineItem.position: 20
  key SalesOrderItem,

      @UI: {
        selectionField.position: 20,
        lineItem.position: 30
      }

      @Consumption.valueHelp: '_Employees'
      _SalesOrder._CreatedByUser.Employee,

      @EndUserText.label: 'Creation Date'
      @UI: {
        selectionField.position: 30,
        lineItem.position: 40
      }
      tstmp_to_dats(_SalesOrder.CreationDateTime,
                    abap_system_timezone($session.client,'NULL'),
                    $session.client,
                    'NULL')                                                           as CreationDate,

      @UI.lineItem.position: 50
      @Search: {
        defaultSearchElement: true,
        fuzzinessThreshold: 0.8,
        ranking: #HIGH
      }
      _SalesOrder._Customer.CompanyName                                               as CompanyName,

      @UI: {
        lineItem.position: 60,
        selectionField.position: 40
      }
      _SalesOrder._Customer._Address.Country,

      @UI.lineItem.position: 70
      NetAmountInTransactionCurrency,

      @UI.hidden: true
      TransactionCurrency,

      @UI.lineItem.position: 80
      _ScheduleLine.Quantity,

      @UI.hidden: true
      _ScheduleLine.QuantityUnit,

      @UI: {
        selectionField.position: 50,
        lineItem.position: 90
      }
      _Product.Product,

      @UI.lineItem.position: 100
      @Search: {
        defaultSearchElement: true,
        fuzzinessThreshold: 0.8,
        ranking: #HIGH
      }
      _Product._NameGroup._ShortText[ Language = $session.system_language ].ShortText as ProductText,

      _Employees
}