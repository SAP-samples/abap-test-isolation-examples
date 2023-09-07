@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZATI_CDS_ENTITY
  as select from demo_sales_so_i
{
  key parent_key                  as SalesOrder,
      count(distinct so_item_key) as ItemCount
}
group by
  parent_key
