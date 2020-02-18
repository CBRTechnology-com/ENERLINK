pageextension 50102 ExtendSaleQuoteSubform extends "Sales Quote Subform"
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

    var
        myInt: Integer;
        recItem: Record Item;

    trigger OnAfterGetRecord()
    begin
        GetItemDataFosSales("No.");
    end;
}