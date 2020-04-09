tableextension 50001 ExtendSalesLine extends "Sales Line"
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
        field(50002; "Item Substitute"; Code[20])
        {
            Caption = 'Item Substitute';
            ObsoleteState = Removed;

        }
        field(50003; "Profit Margin"; Decimal)
        {
            Caption = 'Profit Margin';
            Editable = false;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                GetItemDataFosSales("No.");
                UpdateProfitMargin;
            end;

        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                UpdateProfitMargin;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                AvlQtyAfterSales: Decimal;
            begin

                AvlQtyAfterSales := 0;
                GetItemDataFosSales("No.");
                if ("Qty Available" > 0) and ("Qty Available" < quantity) THEN
                    Validate("Qty. to Ship", "Qty Available");

                if "Qty Available" <= 0 then begin
                    AvlQtyAfterSales := 0;
                    Validate("Qty. to Ship", AvlQtyAfterSales);
                end;

            end;
        }
    }

    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        UpdateProfitMargin();

    end;

    var
        myInt: Integer;
        recItem: Record Item;
        ItemSubstitution: Record "Item Substitution";


    procedure GetItemDataFosSales(ItemNo: Code[20])
    begin
        if recItem.Get(ItemNo) then begin
            recItem.CalcFields(Inventory);
            recItem.CalcFields("Qty. on Sales Order");
            "Quantity on Hand" := recItem.Inventory;
            "Qty Available" := (recItem.Inventory - recItem."Qty. on Sales Order");
        end;
    end;

    procedure ItemSubstitutePopup(recItemNo: Code[20])
    var
        recsalesLine: Record "Sales Line";
        text001: Label 'Cross Selling items are configured for the item you have selected. Please click on the Item Substitution link from Action: Line-> Related Information-> Select Item Substitution.';
        ItemSubstitutePage: page "Item Substitution Entries";
        SalesOrderSubform: Page "Sales Order Subform";
    begin
        ItemSubstitution.Reset();
        ItemSubstitution.SetRange("No.", recItemNo);
        if ItemSubstitution.FindFirst() then
            Message(text001);
    end;

    procedure UpdateProfitMargin()
    begin
        If ("Unit Price" = 0) then
            exit;
        if ("Unit Price" > "Unit Cost (LCY)") then
            "Profit Margin" := (("Unit Price" - "Unit Cost (LCY)") / "Unit Price") * 100
        else
            "Profit Margin" := 0;
    end;


}