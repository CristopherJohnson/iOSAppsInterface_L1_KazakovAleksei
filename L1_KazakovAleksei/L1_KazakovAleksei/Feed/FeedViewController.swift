//
//  FeedViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 11/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    var newsArray: [NewsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        
        let images = ["NewsImage1", "NewsImage2", "NewsImage3", "NewsImage4"]
        let text = ["Эти типы ячеек используются во многих приложениях от Apple, но редко — от других компаний, так как они не соответствуют их дизайну.", "Чтобы сделать кастомную ячейку, нужно создать наследника класса UITableViewCell.​В этом классе можно объявить I​BOutlet’s для вложенных UI-компонентов и нужно переопределить метод prepareForReuse.​ Он вызывается в момент, когда ячейка будет переиспользована. В нем необходимо подготовить ячейку — убрать надписи с лейблов и удалить картинки из ​UIImageView.​ Если этого не сделать, в ячейке могут остаться данные из предыдущего состояния.", "У таблицы, как и у секций, есть header и f​ooter.​Они располагаются вверху и внизу таблицы. Не переиспользуются и чаще всего отображают статичный контент — например, строку поиска или индикатор загрузки. Чтобы добавить в таблицу header или footer,​ нужно установить свойства tableHeaderView и t​ableFooterView.​ В роли этих ​view может выступать любой наследник ​UIView.​ Важно установить f​rame у ​view перед тем, как добавлять ее в качестве ​header или footer.​ Чтобы изменить размер ​header или f​ooter,​нужно установить новый f​rame и вызвать метод r​eloadData у таблицы.", "Если вызвать несколько этих методов"]
        for i in 0...(text.count - 1) {
            let news = NewsModel()
            news.newsImageName = images[i]
            news.newsText = text[i]
            newsArray.append(news)
        }
        
        tableView?.estimatedRowHeight = UITableView.automaticDimension
        tableView?.rowHeight = UITableView.automaticDimension
    }

}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        let news = self.newsArray[indexPath.row]
        cell.setNews(settingNews: news)
        return cell
    }
    
    
}
