pageextension 50101 ExtendSalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addafter("Qty. to Assemble to Order")
        {
            field("Quantity on Hand"; "Quantity on Hand")
            {
                ApplicationArea = All;
            }
            field("Qty Available"; "Qty Available")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
        recItem: Record Item;

    trigger OnAfterGetRecord()
    begin
        GetItemDataFosSales("No.");
    end;
}