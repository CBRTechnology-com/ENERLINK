tableextension 50010 ExtendSalesShipmentLine extends "Sales Shipment Line"
{
    fields
    {
        field(50002; "Item Substitute"; Code[20])
        {
            Caption = 'Item Substitute';
            ObsoleteState = Removed;
        }
    }

    var
        myInt: Integer;
}