pageextension 50103 ExtendSalesCrMemoSubform extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Quantity)
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
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        recItem: Record Item;

    trigger OnAfterGetRecord()
    begin
        GetItemDataFosSales("No.");
    end;
}