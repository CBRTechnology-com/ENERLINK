pageextension 50105 ExtendPurchaseOrderSubform extends "Purchase Order Subform"
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
        addafter("O&rder")
        {
            group("Print Label")
            {
                action("Label")
                {
                    ApplicationArea = all;
                    Caption = 'Print Label';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Print;
                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(Rec);
                        REPORT.RUN(50204, TRUE, FALSE, Rec);
                        Reset();
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
        recItem: Record Item;

    trigger OnAfterGetRecord()
    begin
        GetItemDataForPurcahse("No.");
    end;
}