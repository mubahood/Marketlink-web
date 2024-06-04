@php
    use App\Models\Utils;

@endphp
<!DOCTYPE html>
<html>

<head>
    <title>Financial Report</title>
    @include('css.css')
    <style>
        .my-table {
            border-collapse: collapse;
            border: 1px solid black;
            border-radius: 15px;
        }

        .my-table th,
        .my-table td {
            border: 1px solid black;
            padding: 5px;
        }

        .my-table th {
            background-color: #f2f2f2;
        }

        .my-card {
            border: 1px solid black;
            padding: 10px;
            border-radius: 5px;
        }

        .my-card p {
            margin: 0;
        }

        .my-card span {
            margin-right: 5px;
        }

        .my-table th,
        .my-table td {
            border: 1px solid black;
            padding: 5px;
        }
    </style>
</head>

<body>
    <table class="w-100">
        <tr>
            <td style="width: 16%">
            </td>
            <td>
                <div class="text-center">
                    <p class="fs-18 text-center fw-700 mt-2 text-uppercase  " style="color: black;">
                        {{ $company->name }}</p>
                    <p class="fs-14 lh-6 mt-1">TEL:
                        {{ $company->phone_number }},&nbsp;{{ $company->chairperson_phone_number }}
                    </p>
                    <p class="fs-14 lh-6 mt-1">EMAIL: {{ $company->email }}</p>
                    <p class="fs-14 mt-1">{{ $company->slogan }}</p>
                </div>
            </td>
            <td style="width: 16%">
                @if ($company->logo != null)
                    <img style="width: 80%; " src="{{ public_path('storage/' . $company->logo) }}">
                @endif
            </td>
        </tr>
    </table>

    <hr style="height: 3px; background-color:  black;" class=" mt-3 mb-0">
    <hr style="height: .3px; background-color:  black;" class=" mt-1 mb-4">
    <p class="fs-18 text-center mt-2 text-uppercase black mb-4 fw-700"><u>
            {{ $data->title }}</u></p>
    <p class="text-right mb-4"> <small><u>DATE: {{ Utils::my_date($data->created_at) }}</u></small></p>
    <table style="width: 100%">
        <thead>
            @if ($data->type == 'Financial')
                <tr>
                    <td style="width: 30%;">
                        <div class="my-card mr-1">
                            <p class="black fs-14 fw-700">Total Income</p>
                            <p class="py-3"><span>UGX</span><span
                                    class="fs-26 fw-800">{{ number_format($data->total_income) }}</span>
                            </p>
                        </div>
                    </td>
                    <td style="width: 30%;">
                        <div class="my-card mx-1">
                            <p class="black fs-14 fw-700">Total Expenses</p>
                            <p class="py-3"><span>UGX</span><span
                                    class="fs-26 fw-800">{{ number_format($data->total_expenses) }}</span>
                            </p>
                        </div>
                    </td>
                    <td style="width: 30%;">
                        <div class="my-card ml-1">
                            <p class="black fs-14 fw-700">Profit or Loss</p>
                            <p class="py-3"><span>UGX</span><span
                                    class="fs-26 fw-800">{{ number_format($data->profit) }}</span>
                            </p>
                        </div>
                    </td>
                </tr>
            @else
                <tr>
                    <td style="width: 30%;">
                        <div class="my-card mr-1">
                            <p class="black fs-14 fw-700">Total Investment</p>
                            <p class="py-3"><span>UGX</span><span
                                    class="fs-26 fw-800">{{ number_format($data->inventory_total_buying_price) }}</span>
                            </p>
                        </div>
                    </td>
                    <td style="width: 30%;">
                        <div class="my-card mx-1">
                            <p class="black fs-14 fw-700">Total Sales</p>
                            <p class="py-3"><span>UGX</span><span
                                    class="fs-26 fw-800">{{ number_format($data->inventory_total_selling_price) }}</span>
                            </p>
                        </div>
                    </td>
                    <td style="width: 30%;">
                        <div class="my-card ml-1">
                            <p class="black fs-14 fw-700">Profits/Loss</p>
                            <p class="py-3"><span>UGX</span><span
                                    class="fs-26 fw-800">{{ number_format($data->inventory_total_earned_profit) }}</span>
                            </p>
                        </div>
                    </td>
                </tr>
            @endif

        </thead>
    </table>

    @if ($data->include_finance_accounts == 'Yes')
        <div class="mt-4">
            <p class="fs-18 text-center mt-2 text-uppercase black mb-2 fw-700"><u>Finance Accounts</u></p>
            <table class="w-100 my-table">
                <thead>
                    <tr>
                        <th class="fs-14 fw-700 text-center">Account</th>
                        <th class="fs-14 fw-700 text-center">Expenses</th>
                        <th class="fs-14 fw-700 text-center">Income</th>
                        <th class="fs-14 fw-700 text-center">Balance</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($data->finance_accounts() as $account)
                        <tr>
                            <td>{{ $account->name }}</td>
                            <td class="text-right">{{ number_format($account->total_expense) }}</td>
                            <td class="text-right">{{ number_format($account->total_income) }}</td>
                            <td class="text-right">
                                {{ number_format($account->total_income - $account->total_expense) }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    @endif

    @if ($data->include_finance_records == 'Yes')
        <?php
        $records = $data->finance_records();
        ?>

        <div class="mt-4">
            <p class="fs-18 text-center mt-2 text-uppercase black mb-2 fw-700"><u>Finance Records</u></p>
            @if ($records->count() == 0)
                @include('partials.table_no_data')
            @else
                <table class="w-100 my-table">
                    <thead>
                        <tr>
                            <th class="fs-14 fw-700 text-center">Date</th>
                            <th class="fs-14 fw-700 text-center">Description</th>
                            <th class="fs-14 fw-700 text-center">Amount</th>
                            <th class="fs-14 fw-700 text-center">Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($records as $record)
                            <tr>
                                <td>{{ Utils::my_date($record->created_at) }}</td>
                                <td>{{ $record->description }}</td>
                                <td
                                    class="text-right
                                    {{ $record->type == 'Income' ? 'text-success' : 'text-danger' }}">
                                    {{ number_format($record->amount) }}</td>
                                <td>{{ $record->type }}</td>
                            </tr>
                        @endforeach

                    </tbody>
                </table>
            @endif
        </div>
    @endif



    @if ($data->inventory_include_categories == 'Yes')
        <?php
        $finance_records = $data->get_inventory_categories();
        ?>
        <div class="mt-4">
            <p class="fs-18 text-center mt-2 text-uppercase black mb-2 fw-700"><u>Invetory Categories</u></p>
            @if (count($finance_records) == 0)
                @include('partials.table_no_data')
            @else
                <table class="w-100 my-table">
                    <thead>
                        <tr>
                            <th class="fs-14 fw-700 text-center">Item</th>
                            <th class="fs-14 fw-700 text-center">Total Investment</th>
                            <th class="fs-14 fw-700 text-center">Total Sales</th>
                            <th class="fs-14 fw-700 text-center">Profit/Loss</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($finance_records as $record)
                            <tr>
                                <td>{{ $record->name }}</td>
                                <td class="text-right ">{{ number_format($record->total_buying_price) }}
                                </td>
                                <td class="text-right">{{ number_format($record->total_sales) }}</td>
                                <td class="text-right   {{ $record->profit > 0 ? 'text-success' : 'text-danger' }}">
                                    {{ number_format($record->profit) }}</td>
                            </tr>
                        @endforeach

                    </tbody>
                </table>
            @endif
        </div>
    @endif

    {{-- inventory_include_products --}}
    @if ($data->inventory_include_products == 'Yes')
        <?php
        $finance_records = $data->get_inventory_items();
        ?>
        <div class="mt-4">
            <p class="fs-18 text-center mt-2 text-uppercase black mb-2 fw-700"><u>Inventory Products</u></p>
            @if (count($finance_records) == 0)
                @include('partials.table_no_data')
            @else
                <table class="w-100 my-table">
                    <thead>
                        <tr>
                            <th class="fs-14 fw-700 text-center">Item</th>
                            <th class="fs-14 fw-700 text-center">Buying Price</th>
                            <th class="fs-14 fw-700 text-center">Selling Price</th>
                            <th class="fs-14 fw-700 text-center">Original Quantity</th>
                            <th class="fs-14 fw-700 text-center">Current Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($finance_records as $record)
                            <tr>
                                <td>{{ $record->name }}</td>
                                <td class="text-right ">{{ number_format($record->buying_price) }} </td>
                                <td class="text-right ">{{ number_format($record->selling_price) }} </td>
                                <td class="text-right ">{{ number_format($record->original_quantity) }} </td>
                                <td class="text-right ">{{ number_format($record->current_quantity) }} </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            @endif
        </div>
    @endif
</body>

</html>
