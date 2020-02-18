tableextension 50002 ExtendPurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "Quantity on Hand"; Decimal)
        {
            Caption = 'Qty on Hand';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Qty Available"; Decimal)
        {
            Caption = 'Qty Available';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                "Quantity on Hand" := 0;
                "Qty Available" := 0;
                GetItemDataForPurcahse("No.");
            end;
        }
    }

    var
        myInt: Integer;
        recItem: Record Item;

    procedure GetItemDataForPurcahse(ItemNo: Code[20])
    begin
        if recItem.Get(ItemNo) then begin
            recItem.CalcFields(Inventory);
            recItem.CalcFields("Qty. on Purch. Order");
            "Quantity on Hand" := recItem.Inventory;
            "Qty Available" := (recItem.Inventory - recItem."Qty. on Purch. Order");
        end;
    end;
}