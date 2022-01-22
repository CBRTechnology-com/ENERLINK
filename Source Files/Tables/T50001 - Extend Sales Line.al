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
        field(50004; "Assmebly BOM"; Boolean)
        {
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Caption = 'Assembly BOM';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Expected Arrival Date"; Date)
        {
            Caption = 'Expected Arrival Date';

        }
        field(50006; "Qty. on Purch. Order"; Decimal)
        {
            Caption = 'Qty. on Purch. Order';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(50007; "Qty. on Sales Order"; Decimal)
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
                if ("Qty Available" > 0) and ("Qty Available" < Quantity) THEN
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
            recItem.CalcFields(Inventory, "Qty. on Sales Order", "Qty. on Purch. Order");
            "Quantity on Hand" := recItem.Inventory;
            "Qty. on Purch. Order" := recItem."Qty. on Purch. Order";
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