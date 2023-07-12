//
//  MiniTrack.swift
//  test1
//
//  Created by Hung Vu on 11/07/2023.
//

import UIKit

class MiniTrackView: UIView {
    // Khai báo các thành phần của giao diện
    let songTitleLabel = UILabel()
    let songImageView = UIImageView()
    let nextButton = UIButton()
    let playButton = UIButton()

    // Khởi tạo
    init(songTitle: String, songImage: UIImage) {
        self.songTitleLabel.text = songTitle
        self.songImageView.image = songImage
        super.init(frame: .zero)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Thiết lập giao diện
    private func setupView() {
        // Thiết lập các thuộc tính cho các thành phần
        songTitleLabel.textAlignment = .center
        nextButton.setTitle("Next", for: .normal)
        playButton.setTitle("Play", for: .normal)

        // Thêm các thành phần vào view
        addSubview(songTitleLabel)
        addSubview(songImageView)
        addSubview(nextButton)
        addSubview(playButton)

        // Thiết lập Auto Layout cho các thành phần
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Vị trí và kích thước của nhãn tên bài hát
            songTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            songTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            songTitleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            songTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            // Vị trí và kích thước của hình ảnh bài hát
            songImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            songImageView.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 8),
            songImageView.widthAnchor.constraint(equalToConstant: 100),
            songImageView.heightAnchor.constraint(equalToConstant: 100),

            // Vị trí và kích thước của nút "Next"
            nextButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16),
            nextButton.topAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: 8),
            nextButton.widthAnchor.constraint(equalToConstant: 80),
            nextButton.heightAnchor.constraint(equalToConstant: 30),

            // Vị trí và kích thước của nút "Play"
            playButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            playButton.topAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: 8),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
