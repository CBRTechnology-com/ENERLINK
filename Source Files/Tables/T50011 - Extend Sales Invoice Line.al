tableextension 50011 ExtendSalesInvoiceLine extends "Sales Invoice Line"
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