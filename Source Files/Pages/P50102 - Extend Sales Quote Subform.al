pageextension 50102 ExtendSaleQuoteSubform extends "Sales Quote Subform"
{
    layout
    {
        addafter("Qty. to Assemble to Order")
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
                        Rec."Expected Arrival Date" := RecPurchaseline."Expected Receipt Date";
                        Rec.MODIFY;
                    end;
                end;
            }
        }
        addafter("Unit Price")
        {
            field("Profit Margin"; "Profit Margin")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Assmebly BOM"; "Assmebly BOM")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Tax Group Code")
        {
            field("Expected Arrival Date"; "Expected Arrival Date")
            {
                ApplicationArea = All;
                Caption = 'Expected Arrival Date';
                Editable = false;

            }
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                ItemSubstitutePopup("No.");
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                UpdateProfitMargin();
            end;
        }


    }

    var
        myInt: Integer;
        recItem: Record Item;

    trigger OnAfterGetRecord()
    begin
        GetItemDataFosSales("No.");
        UpdateProfitMargin();
    end;
}