// 이전에 선택한 스마트메일함 목록 항목을 Local Storage 에서 가져와서 설정하는 함수
(function restoreSelectedSmartCategory() {
    const selectedSmartCategory = localStorage.getItem('selectedSmartCategory');
    const categoriesBox = document.getElementById('categories-box');
    const categoryItems = document.getElementById('category-items');

    if(selectedSmartCategory === 'Y') {
        categoriesBox.innerHTML = `
            <div class="sidebar-title" id="categories-box" style="font-size: medium;"><i class="bi bi-stack"></i> 스마트메일함<i class="bi bi-caret-up" style="padding-left: 210px"></i></div>
            `;
        categoryItems.innerHTML = `
            <li><a href="/smart/promotion?page=1" style="padding-left: 20px">프로모션 <span></span></a></li>
            <li><a href="/smart/charge?page=1" style="padding-left: 20px">청구 및 결제 <span></span></a></li>
            <li><a href="/smart/sns?page=1" style="padding-left: 20px">SNS <span></span></a></li>
            `;
    }
})()

//스마트메일함 목록 생성기
document.getElementById('categories-box').addEventListener('click', function(event) {
    event.preventDefault();
    toggleCategoryList();
});

function toggleCategoryList() {
    const categoriesBox = document.getElementById('categories-box');
    const categoryItems = document.getElementById('category-items');

    console.log(localStorage.getItem('selectedSmartCategory') === null)

    if (localStorage.getItem('selectedSmartCategory') === null) {
        categoriesBox.innerHTML = `
            <div class="sidebar-title" id="categories-box" style="font-size: medium;"><i class="bi bi-stack"></i> 스마트메일함<i class="bi bi-caret-up" style="padding-left: 210px"></i></div>
            `;

        categoryItems.innerHTML = `
            <li><a href="/smart/promotion?page=1" style="padding-left: 20px">프로모션 <span></span></a></li>
            <li><a href="/smart/charge?page=1" style="padding-left: 20px">청구 및 결제 <span></span></a></li>
            <li><a href="/smart/sns?page=1" style="padding-left: 20px">SNS <span></span></a></li>
            `;

        localStorage.setItem('selectedSmartCategory', 'Y');
        return;
    }

    if (localStorage.getItem('selectedSmartCategory') === 'Y') {
        categoriesBox.innerHTML = `
            <div class="sidebar-title" id="categories-box" style="font-size: medium;"><i class="bi bi-stack"></i> 스마트메일함<i class="bi bi-caret-down" style="padding-left: 210px"></i></div>
            `;
        categoryItems.innerHTML = ''; // 목록 초기화
        localStorage.removeItem('selectedSmartCategory');
    }

}

// 필터 (선택한 'sort' 전달)
function applySort(sortValue) {
    const currentFilter = getParameterByName('filter');
    let newUrl;

    if (window.location.href.indexOf('receive') !== -1) {
        newUrl = '/receive/list/folder?filter=' + currentFilter + '&sort=' + sortValue + '&page=1';
    } else if (window.location.href.indexOf('promotion') !== -1) {
        newUrl = '/smart/promotion/folder?filter=' + currentFilter + '&sort=' + sortValue + '&page=1';
    } else if (window.location.href.indexOf('charge') !== -1) {
        newUrl = '/smart/charge/folder?filter=' + currentFilter + '&sort=' + sortValue + '&page=1';
    } else if (window.location.href.indexOf('sns') !== -1) {
        newUrl = '/smart/sns/folder?filter=' + currentFilter + '&sort=' + sortValue + '&page=1';
    }
    window.location.href = newUrl;
}

// 정렬 (선택한 'filter' 전달)
function applyFilter(filterValue) {
    const currentSort = getParameterByName('sort') || 0;
    let newUrl;

    if (window.location.href.indexOf('receive') !== -1) {
        newUrl = '/receive/list/folder?filter=' + filterValue + '&sort=' + currentSort + '&page=1';
    } else if (window.location.href.indexOf('promotion') !== -1) {
        newUrl = '/smart/promotion/folder?filter=' + filterValue + '&sort=' + currentSort + '&page=1';
    } else if (window.location.href.indexOf('charge') !== -1) {
        newUrl = '/smart/charge/folder?filter=' + filterValue + '&sort=' + currentSort + '&page=1';
    } else if (window.location.href.indexOf('sns') !== -1) {
        newUrl = '/smart/sns/folder?filter=' + filterValue + '&sort=' + currentSort + '&page=1';
    }
    window.location.href = newUrl;
}

// 이미 선택되어진 'sort' 또는 'filter' 유지
function getParameterByName(name) {
    const url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    const regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

// receiveList 의 타이틀 선택시 메일 세부 사항 경로
function getUrlForDetail(element) {
    const currentNo = element.getAttribute("no");
    const currentFilter = element.getAttribute("filter");
    const currentSort = element.getAttribute("sort");
    const currentPage = element.getAttribute("page");
    let newUrl;

    if (window.location.href.indexOf('receive') !== -1) {
        newUrl = '/receive/detail?no=' + currentNo + '&filter=' + currentFilter + '&sort=' + currentSort + '&page=' + currentPage;
    } else if (window.location.href.indexOf('promotion') !== -1) {
        newUrl = '/smart/promotion/detail?no=' + currentNo + '&filter=' + currentFilter + '&sort=' + currentSort + '&page=' + currentPage;
    } else if (window.location.href.indexOf('charge') !== -1) {
        newUrl = '/smart/charge/detail?no=' + currentNo + '&filter=' + currentFilter + '&sort=' + currentSort + '&page=' + currentPage;
    } else if (window.location.href.indexOf('sns') !== -1) {
        newUrl = '/smart/sns/detail?no=' + currentNo + '&filter=' + currentFilter + '&sort=' + currentSort + '&page=' + currentPage;
    }
    window.location.href = newUrl;
}

// '별표' 이미지 선택시 likeChecked 변경
function changeLikeChecked(imgElement) {
    const no = imgElement.getAttribute("no");
    let likeChecked = imgElement.getAttribute("like-status");
    const page = imgElement.getAttribute("page");

    console.log(no);
    console.log(likeChecked);
    if(likeChecked === 'Y') {
        likeChecked = 'N';
    } else {
        likeChecked = 'Y';
    }
    updateLikeStatus(no, likeChecked, page);
}

// no, likeChecked 서버로 전달
function updateLikeStatus(no, likeChecked, page) {
    axios.post('/receive/update/mark',
        {no: no, likeChecked: likeChecked},
        {params: { page: page }, 'Content-Type': 'application/json'})
        .then(() => {window.location.reload()})
        .catch(() => {alert('실패')})
}

// '봉투' 이미지 선택시 readStatus 변경
function changeReadStatus(imgElement) {
    const no = imgElement.getAttribute("no");
    let readStatus = imgElement.getAttribute("read-status");
    const page = imgElement.getAttribute("page");

    if(readStatus === 'Y') {
        readStatus = 'N';
    } else {
        readStatus = 'Y';
    }
    updateReadStatus(no, readStatus, page);
}

// no, readStatus 서버로 전달
function updateReadStatus(no, readStatus, page) {
    axios.post('/receive/update/readStatus',
        {no: no, readStatus: readStatus},
        {params: { page: page },'Content-Type': 'application/json'})
        .then(() => {window.location.reload()})
        .catch(() => {alert('실패')})
}

const checkboxes = document.querySelectorAll('input[type="checkbox"]');
const trashBox = document.getElementById('trash-box');

// 체크 박스 선택되면 '삭제' 버튼 활성화, 선택되지 않으면 '삭제' 버튼 비활성화
checkboxes.forEach(checkbox => {
    checkbox.addEventListener('click', function () {
        const anyCheckboxChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
        if (anyCheckboxChecked) {
            trashBox.classList.remove('inactive');
            trashBox.classList.add('active');
        } else {
            trashBox.classList.remove('active');
            trashBox.classList.add('inactive');
        }
    });
});

// 체크 박스 선택된 'no' 배열로 저장 (체크박스)
function sendToTrash(element) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
    const selectedItems = Array.from(checkboxes).map(checkbox => checkbox.value);
    const page = element.getAttribute("page");

    updateTrash(selectedItems, page);
}

// 선택된 'no' 배열 서버로 전달 (체크박스)
function updateTrash(selectedItems, page) {
    axios.post('/receive/update/trashes',
        { selectedItems: selectedItems },
        {params: { page: page }, 'Content-Type': 'application/json'})
        .then(() => {
            window.location.reload();
        })
        .catch(() => {
            alert('실패');
        });
}
