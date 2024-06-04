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
                        {{ $data->name }}</p>
                    <p class="fs-14 lh-6 mt-1">R.S.V.P:
                        {{ $company->phone_number }},&nbsp;{{ $company->chairperson_phone_number }}
                    </p>
                    <p class="fs-14 lh-6 mt-1">EMAIL: {{ $company->email }}</p>
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
    <p class="fs-18 text-center mt-2 text-uppercase black mb-4 fw-700"><u>Proposed Budget - Report</u></p>
    <p class="text-right mb-4"> <small><u>AS ON: {{ Utils::my_date(time()) }}</u></small></p>
    <table style="width: 100%">
        <thead>
            <tr>
                <td style="width: 30%;">
                    <div class="my-card mr-1">
                        <p class="black fs-14 fw-700">Overall Budget</p>
                        <p class="py-3"><span>UGX</span><span
                                class="fs-26 fw-800">{{ number_format($data->budget_total) }}</span>
                        </p>
                    </div>
                </td>
                <td style="width: 30%;">
                    <div class="my-card mx-1">
                        <p class="black fs-14 fw-700">Budget Covered</p>
                        <p class="py-3"><span>UGX</span><span
                                class="fs-26 fw-800">{{ number_format($data->budget_spent) }}</span>
                        </p>
                    </div>
                </td>
                <td style="width: 30%;">
                    <div class="my-card ml-1">
                        <p class="black fs-14 fw-700">Pending Budget</p>
                        <p class="py-3"><span>UGX</span><span
                                class="fs-26 fw-800">{{ number_format($data->budget_balance) }}</span>
                        </p>
                    </div>
                </td>
            </tr>
        </thead>
    </table>

    <div class="mt-4">
        <p class="fs-18 text-center mt-2 text-uppercase black mb-2 fw-700"><u>Summary</u></p>
        <table class="w-100 my-table">
            <thead>
                <tr>
                    <th class="fs-14 fw-700 text-center">Sn.</th>
                    <th class="fs-14 fw-700 text-center">Category</th>
                    <th class="fs-14 fw-700 text-center">Target</th>
                    <th class="fs-14 fw-700 text-center">Covered</th>
                    <th class="fs-14 fw-700 text-center">Pending Budget</th>
                    <th class="fs-14 fw-700 text-center">Percentage<br>Covered</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $sn = 1;
                    $total_target = 0;
                    $total_covered = 0;
                    $total_pending = 0;
                    $total_percentage = 0;
                @endphp
                @foreach ($data->get_categories() as $account)
                    <?php
                    $total_target += $account->target_amount;
                    $total_covered += $account->invested_amount;
                    $total_pending += $account->balance;
                    $total_percentage += $account->percentage_done;
                    ?>
                    <tr>
                        <td>{{ $sn++ }}</td>
                        <td>{{ $account->name }}</td>
                        <td class="text-right">{{ number_format($account->target_amount) }}</td>
                        <td class="text-right">{{ number_format($account->invested_amount) }}</td>
                        <td class="text-right">
                            {{ number_format($account->balance) }}</td>
                        <td class="text-right"
                            style="font-weight: 800; color: {{ $account->percentage_done < 50 ? 'red' : 'green' }}">
                            {{ $account->percentage_done }}%
                    </tr>
                @endforeach
                <tr>
                    <td></td>
                    <td class="fw-700">Total</td>
                    <td class="text-right fw-700">{{ number_format($total_target) }}</td>
                    <td class="text-right fw-700">{{ number_format($total_covered) }}</td>
                    <td class="text-right fw-700">{{ number_format($total_pending) }}</td>
                    <td class="text-right fw-700">{{ $sn > 1 ? number_format($total_percentage / ($sn - 1), 2) : 0 }}%
                    </td>
                </tr>
            </tbody>
        </table>
    </div>


    <div class="mt-4">
        <p class="fs-18 text-center mt-2 text-uppercase black mb-2 fw-700"><u>Detailed Budget</u></p>
        <table class="w-100 my-table">
            <thead>
                <tr>
                    <th class="fs-14 fw-700 text-center">Sn.</th>
                    <th class="fs-14 fw-700 text-center">Category</th>
                    <th class="fs-14 fw-700 text-center">Target</th>
                    <th class="fs-14 fw-700 text-center">Covered</th>
                    <th class="fs-14 fw-700 text-center">Pending Budget</th>
                    <th class="fs-14 fw-700 text-center">Percentage<br>Covered</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $sn = 1;
                    $total_target = 0;
                    $total_covered = 0;
                    $total_pending = 0;
                    $total_percentage = 0;
                @endphp
                @foreach ($data->get_categories() as $account)
                    <?php
                    $total_target = 0;
                    $total_covered = 0;
                    $total_pending = 0;
                    $total_percentage = 0;
                    ?>
                    <tr style="background-color: black; color: white;">
                        <td>##</td>
                        <td>{{ $account->name }}</td>
                        <td class="text-right"></td>
                        <td class="text-right"></td>
                        <td class="text-right"></td>
                        <td class="text-right"></td>
                    </tr>
                    <?php
                    $sn = 1;
                    ?>
                    @foreach ($account->get_items() as $sub_account)
                        <?php
                        $total_target += $sub_account->target_amount;
                        $total_covered += $sub_account->invested_amount;
                        $total_pending += $sub_account->balance;
                        $total_percentage += $sub_account->percentage_done;
                        ?>
                        <tr>
                            <td>{{ $sn++ }}</td>
                            <td>{{ $sub_account->name }}</td>
                            <td class="text-right ">{{ number_format($sub_account->target_amount) }}</td>
                            <td class="text-right ">{{ number_format($sub_account->invested_amount) }}</td>
                            <td class="text-right ">
                                {{ number_format($sub_account->balance) }}</td>
                            <td class="text-right "
                                style="font-weight: 800; color: {{ $sub_account->percentage_done < 50 ? 'red' : 'green' }}">
                                {{ $sub_account->percentage_done }}% </td>
                        </tr>
                    @endforeach
                    <tr>
                        <td></td>
                        <td class="fw-700">Sub-Total</td>
                        <td class="text-right fw-700">{{ number_format($total_target) }}</td>
                        <td class="text-right fw-700">{{ number_format($total_covered) }}</td>
                        <td class="text-right fw-700">{{ number_format($total_pending) }}</td>
                        <td class="text-right fw-700">
                            {{ $sn > 1 ? number_format($total_percentage / ($sn - 1), 2) : 0 }}%
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>


</body>

</html>
