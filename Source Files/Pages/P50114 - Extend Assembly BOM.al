pageextension 50114 ExtendAssemblyBOM extends "Assembly BOM"
{
    layout
    {
        addafter("Quantity per")
        {
            field("Qty. on Hand"; Rec."Qty. on Hand")
            {
                ApplicationArea = All;
            }
            field("Qty. Available"; Rec."Qty. Available")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Prod. Order"; "Qty. on Prod. Order")
            {
                ApplicationArea = All;
            }

        }

    }


    var

        recBOM: Record "BOM Component";

    trigger OnAfterGetRecord()
    begin
        if recBOM.Get("Parent Item No.", "Line No.") then begin
            recBOM.CalcFields("Qty. on Hand");
            recBOM.CalcFields("Qty. on Sales Order");
            "Qty. Available" := recBOM."Qty. on Hand" - recBOM."Qty. on Sales Order";
        end;
    end;
}