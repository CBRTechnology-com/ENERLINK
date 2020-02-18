tableextension 50007 ExtendItemTable extends item
{
    fields
    {

        field(50000; Qty_Available; decimal)
        {
            Description = 'Qty Available';
            DecimalPlaces = 0;
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