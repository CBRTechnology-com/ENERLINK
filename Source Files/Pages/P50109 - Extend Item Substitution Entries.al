pageextension 50109 ExtendItemSubstitutionEntries extends "Item Substitution Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Condition")
        {
            action("Insert Item Substitute")
            {
                ApplicationArea = All;
                Image = SelectItemSubstitution;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    InsertItemToSalesLine();
                end;
            }
        }

    }

    var
        myInt: Integer;
        recSalesLine: Record "Sales Line";
        recItemSubstitute: Record "Item Substitution";
        LastLineNo: Integer;
        GOrderNo: Code[20];
        Text001: Label 'Item %1 has been successfully added to the Sales Line.';

    trigger OnOpenPage()
    begin
        GOrderNo := "Document No";

    end;

    procedure InsertItemToSalesLine()
    begin
        CurrPage.SETSELECTIONFILTER(recItemSubstitute);
        recSalesLine.RESET;
        recSalesLine.SETRANGE("Document Type", recSalesLine."Document Type"::Order);
        recSalesLine.SETRANGE("Document No.", GOrderNo);
        IF recSalesLine.FINDLAST THEN BEGIN
            LastLineNo := recSalesLine."Line No.";
        END;
        IF recItemSubstitute.FINDFIRST THEN
            REPEAT
                recSalesLine.INIT;
                recSalesLine."Document Type" := recSalesLine."Document Type"::Order;
                recSalesLine."Document No." := GOrderNo;
                recSalesLine."Line No." := LastLineNo + 10000;
                LastLineNo := LastLineNo + 10000;
                recSalesLine.Type := recSalesLine.Type::Item;
                recSalesLine.VALIDATE("No.", recItemSubstitute."Substitute No.");
                recSalesLine.INSERT;
            UNTIL recItemSubstitute.NEXT = 0;
        MESSAGE(Text001, recItemSubstitute."Substitute No.");
        CurrPage.CLOSE
    end;
}