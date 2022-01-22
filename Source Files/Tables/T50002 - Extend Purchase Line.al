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
        field(50002; "Qty. on Purch. Order"; Decimal)
        {
            Caption = 'Qty. on Purch. Order';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(50003; "Qty. on Sales Order"; Decimal)
        {
            Caption = 'Qty. on Sales Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order),
                                                                            Type = CONST(Item),
                                                                            "No." = FIELD("No."),
                                                                            "Outstanding Qty. (Base)" = FILTER(> 0)));
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                GetItemDataForPurcahse("No.");
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
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
            recItem.CalcFields(Inventory, "Qty. on Sales Order", "Qty. on Purch. Order");
            "Quantity on Hand" := recItem.Inventory;
            "Qty. on Purch. Order" := recItem."Qty. on Purch. Order";
            "Qty Available" := (recItem.Inventory - recItem."Qty. on Sales Order");
        end;
    end;
}