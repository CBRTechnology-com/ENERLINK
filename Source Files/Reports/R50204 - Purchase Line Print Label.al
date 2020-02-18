report 50204 "Purchase Line Label Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseLineLabelReport.rdlc';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(No_PurchaseHeader; PurchaseHeaderRec."No.")
                    {
                    }
                    column(PaytoVendorNo_PurchaseHeader; PurchaseHeaderRec."Pay-to Vendor No.")
                    {
                    }
                    column(VendorName_PurchaseHeader; PurchaseHeaderRec."Pay-to Name")
                    {
                    }
                    column(OrderDate_PurchaseHeader; PurchaseHeaderRec."Order Date")
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(ExptRecptDt_PurchaseHeader; PurchaseHeaderRec."Expected Receipt Date")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(Line_No_PurchaseLine; "Purchase Line"."Line No.")
                    {
                    }
                    column(Item_No_PurchaseLine; "Purchase Line"."No.")
                    {
                    }
                    column(Description_PurchaseLine; "Purchase Line".Description)
                    {
                    }
                    column(UnitPriceLCY_PurchaseLine; "Purchase Line"."Unit Price (LCY)")
                    {
                    }
                    column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                    {
                    }
                    column(UnitCost_PuchaseLine; "Purchase Line"."Direct Unit Cost")
                    {
                    }
                    column(UOM_Item; recItem."Base Unit of Measure")
                    {
                    }
                    column(ItemCategoryCode_Item; recItem."Item Category Code")
                    {
                    }
                    column(Manufacture; recManufacture.Name)
                    {
                    }
                    column(Quantity; "Purchase Line".Quantity)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            PurchasePrinted.Run(PurchaseHeaderRec);
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                    TaxAmount := 0;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                RecReservationEntry: Record "Reservation Entry";
            begin
                OnLineNumber := OnLineNumber + 1;

                if recItem.Get("Purchase Line"."No.") then
                    if recManufacture.Get(recItem."Manufacturer Code") then;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoCopies; NoCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        UseExternalTaxEngine: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PurchLine: Record "Purchase Line";
        Text000: Label 'COPY';
        recItem: Record Item;
        PurchaseHeaderRec: Record "Purchase Header";
        recManufacture: Record Manufacturer;
}

