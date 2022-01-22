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
            field("Qty. on Sales Order"; "Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; "Qty. on Purch. Order")
            {
                ApplicationArea = All;
                Caption = 'Qty. on Purch. Order';
                Visible = true;
                Editable = false;
                trigger OnAssistEdit()
                var
                    RecPurchaseline: Record "Purchase Line";
                    PurchasewithRecptDate: Page "Purchase Lines with Recpt Date";
                begin

                    RecPurchaseline.RESET;
                    RecPurchaseline.SETFILTER("No.", '%1', Rec."No.");
                    RecPurchaseline.SETFILTER("Outstanding Quantity", '<>%1', 0);
                    Clear(PurchasewithRecptDate);
                    PurchasewithRecptDate.SetRecord(RecPurchaseline);
                    PurchasewithRecptDate.SetTableView(RecPurchaseline);
                    PurchasewithRecptDate.LookupMode(true);
                    if PurchasewithRecptDate.RunModal() = Action::LookupOK then begin
                        PurchasewithRecptDate.GetRecord(RecPurchaseline);
                        Rec."Expected Receipt Date" := RecPurchaseline."Expected Receipt Date";
                        Rec.MODIFY;
                    end;
                end;

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