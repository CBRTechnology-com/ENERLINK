tableextension 50007 ExtendItemTable extends item
{
    fields
    {

        field(50000; Qty_Available; decimal)
        {
            Description = 'Qty Available';
            DecimalPlaces = 0;
        }
        field(50001; "Visible on WebStore"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Visible on WebStore';
        }
        field(50002; "Visible on Orbis"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Visible on Orbis';
        }
        field(50003; "Qty. on Sales Quote"; Decimal)
        {
            Caption = 'Qty. on Sales Quote';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Quote),
                                                                            Type = CONST(Item),
                                                                            "No." = FIELD("No."),
                                                                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Shipment Date" = FIELD("Date Filter"),
                                                                            "Unit of Measure Code" = FIELD("Unit of Measure Filter")));

        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if item.get("No.") then begin
                    item.CalcFields(Inventory);
                    item.CalcFields("Qty. on Sales Order");
                    Qty_Available := Inventory - "Qty. on Sales Order";
                end;
            end;
        }

    }


    var
        myInt: Integer;
        item: Record Item;

}