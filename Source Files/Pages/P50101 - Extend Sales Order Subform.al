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
        addafter("Unit Price")
        {
            field("Profit Margin"; "Profit Margin")
            {
                ApplicationArea = All;
                Editable = false;

            }
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                ItemSubstitutePopup("No.");
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                UpdateProfitMargin();
            end;
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
        UpdateProfitMargin();
    end;
}